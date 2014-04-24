# encoding: utf-8
class BrandController < ApplicationController
  # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list
    
    return render :json=>Brand.list_all.to_json()
    
  end

    # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands grouped by group
  def list_by_group 
   
    return render :json=>Brand.list_by_group.to_json()
    
  end

end
