# encoding: utf-8
class StoreController < ApplicationController

  def list
     
    return render :json=>Store.list_all
    
  end
  
  def detail
    
    return render :json=>Store.get_by_id({:id=>params[:id]})
  end
end
