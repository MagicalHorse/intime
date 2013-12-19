# encoding: utf-8
class SpecialTopicController < ApplicationController

  def get_list
    render_items(mock_up)
  end

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
      default_resource = select_defaultresource p[:resource]
      next if default_resource.nil?
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :descriptio=>p[:description],
        :createddate =>p[:createdDate],
        :resources=>[{
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name].gsub('\\','/'),
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

  protected

  def mock_up

   (1..9).inject([]) do |_r, _i|
      _r << {
        title:       '四月会员日活动',
        imageUrl:    'http://yt.seekray.net/0909/temp/280_200_1.jpg',
        url:         'http://www.baidu.com',
        startDate:   '2013.06.21',
        endDate:     '2013.06.21',
        description: '喜欢银泰，乐享三倍积点。银泰年中庆，小积点也能玩出大动作，三倍积点大赠送啦！',
        likeCount:   900,
      }

      _r
    end
  end
end
