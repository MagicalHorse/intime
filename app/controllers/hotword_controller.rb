# encoding: utf-8
class HotwordController < ApplicationController
 # list api always return json
  # input: 
  # => {}
  # ouput:
  # => all brands
  def list

    return render :json=>Hotword.list_all.to_json()
    
  end
end
