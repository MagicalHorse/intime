class SpecialTopicController < ApplicationController
  # list api always return json
  # input: 
  # => {page,pagesize,refreshts,sort}
  # ouput:
  # => {}
  def list
    #parse input params
    pageindex = params[:page]
    pageindex ||= 1
    pagesize = params[:pagesize]
    pagesize = [(pagesize ||=20).to_i,20].min
    is_refresh = params[:type] == 'refresh'
    refreshts = params[:refreshts]
    
    # if refreshts not provide but is_refresh, return empty
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>1,
        :pagesize=>0,
        :totalcount=>0,
        :totalpaged=>0,
        :ispaged=> false
      }
     } if is_refresh == true && refreshts.nil?
    #search the special topic
    prod = SpecialTopic.search :per_page=>pagesize, :page=>pageindex do
          query do
            match :status,1
          end
          if is_refresh
            filter :range,{
              'createdDate' =>{
                'gte'=>refreshts.to_datetime
              }
            }
          end
          sort {
            by :createdDate, 'desc'
          }
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      default_resource = p[:resource].sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}.first
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :descriptio=>p[:description],
        :createddate =>p[:createdDate],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name],
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }]
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>pageindex,
        :pagesize=>pagesize,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/pagesize.to_f).ceil,
        :ispaged=> prod.total>pagesize,
        :specialtopics=>prods_hash
      }
     }.to_json()
    
  end
end
