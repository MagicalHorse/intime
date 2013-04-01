class BannerController < ApplicationController
 # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list
    #parse input params
    
    #search the special topic
    prod = Banner.search :per_page=>PAGE_ALL_SIZE do
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
      :data=>
        prods_hash
      
     }.to_json()
    
  end
end
