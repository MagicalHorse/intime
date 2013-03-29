class BrandController < ApplicationController
  # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list
    #parse input params
    
    #search the special topic
    prod = Brand.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
    end
    # render request
    prods_hash = []       
    prod.results.each {|p|
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :address=>p[:address],
        :description=>p[:description],
        :tel=>p[:tel],
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :stores=>prods_hash
      }
     }.to_json()
    
  end
end
