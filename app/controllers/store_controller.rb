class StoreController < ApplicationController
  include ISAuthenticate
  before_filter :auth_api, :only=>[:index]
  def list
     #search the store
    prod = Store.search :per_page=>PAGE_ALL_SIZE do
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
        :location=>p[:address],
        :tel=>p[:tel],
        :lng=>p[:location][:lon],
        :lat=>p[:location][:lat],       
        :description=>p[:description]
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>prods_hash
     }.to_json()
    
  end
  
  def index
    #parse input
    store_id = params[:id]
    return render :json=> error_500 if store_id.nil?
    
    #find the store
    prod = Store.search :per_page=>1,:page=>1 do
          query do
            match :id, store_id
          end
    end
    return render :json=> error_500 if prod.results.length<1
    store_finded = prod.results.first
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
          :id=>store_finded[:id],
          :name=>store_finded[:name],
          :description=>store_finded[:description],
          :englishname=>store_finded[:englishName],
          :createddate =>store_finded[:createdDate],
          :location=> store_finded[:address],
          :tel => store_finded[:tel],
          :lng => store_finded[:lng],
          :lat => store_finded[:lat],
          :gpslat => store_finded[:gpsLat],
          :gpsLng => store_finded[:gpsLng],
          :gpsAlt => store_finded[:gpsAlt]        
      }
     }
  end
end
