class HotwordController < ApplicationController
 # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list

    #search the special topic
    prod = Hotword.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
          sort {
            by :sortOrder,'desc'
          }
    end
    # render request
    words_arr = []    
    brands_arr = []  
    stores_arr = [] 
    prod.results.each {|p|
      if p[:type]==1
        # word
        words_arr<< p[:word]
      elsif p[:type] ==2
        # brand
        brands_arr<< {
          :id=>p[:brandId],
          :name=>p[:word]
        }
      elsif p[:type] ==3
        stores_arr << {
          :id=>p[:storeid],
          :name=>p[:word]
        }
      end
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :words=>words_arr,
        :brandwords=>brands_arr,
        :stores=>stores_arr
      }
      
     }.to_json()
    
  end
end
