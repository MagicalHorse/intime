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
        :website=>p[:website],
        :description=>p[:description],
        :log=>p[:logo],
      }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>
        prods_hash
      
     }.to_json()
    
  end

    # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands grouped by group
  def list_by_group 
    #search the special topic
    prod = Brand.search :per_page=>PAGE_ALL_SIZE do
          query do
            match :status,1
          end
          sort {
            by :group
          }
    end
    # render request  
    group_hash = {} 
    prod.results.each {|p|
      group_value = p[:group]
      group_value ||= '#'
      group_value.upcase!
      group_hash[group_value]=[] if !(group_hash.has_key?(group_value))
      group_hash[group_value]<<{
        :id=>p[:id],
        :name=>p[:name],
        :englishname=>p[:englishName],
        :group=>p[:group],
        :website=>p[:website],
        :description=>p[:description],
        :log=>p[:logo]
      }
    }
    prods_hash = [] 
    group_hash.each do |key,value|
      prods_hash<<{
        :groupname=>key,
        :groupval=>value
      }  
    end
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>
        prods_hash
      
     }.to_json()
    
  end

end
