# encoding: utf-8
require 'json'
class V22::StorePromotionController < ApplicationController
  def list

    return render :json=>StorePromotionES.list_by_page({
      :page=>params[:page],
      :pagesize=>params[:pagesize],
      :type=>params[:type],
      :refreshts=>params[:refreshts]
    })
    
  end
  def detail
    return render :json=>StorePromotionES.get_by_id({:id=>params[:id]})
    
  end
end
