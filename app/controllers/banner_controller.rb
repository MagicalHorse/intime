class BannerController < ApplicationController
 # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list
    #parse input params
    page_index_in = params[:page]
    page_size_in = params[:pagesize]
    page_size = (page_size_in.nil?)?40:page_size_in.to_i
    page_size = 40 if page_size>40
    page_index = (page_index_in.nil?)?1:page_index_in.to_i
    #search the special topic
    prod = Banner.search :per_page=>page_size,:page=>page_index do
          query do
            match :status,1
          end
          sort {
            by :sortOrder,'desc'
          }
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      default_resource = p[:resource].sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}.first
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:id],
        :sortorder=>p[:sortOrder],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name],
          :width=>default_resource[:width],
          :height=>default_resource[:height]
        }],
        :promotionid=>p[:promotion][:id]
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>page_index,
        :pagesize=>page_size,
        :totalcount=>prod.total,
        :totalpaged=>(prod.total/page_size.to_f).ceil,
        :ispaged=> prod.total>page_size,
        :promotions=>prods_hash
      }
     }.to_json()
    
  end
end
