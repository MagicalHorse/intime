# encoding: utf-8
class ProductController < ApplicationController

  def show
    return render :json=>Product.get_by_id({:id=>params[:id]})
  end
  
  # list api always return json
  # input: 
  # => {page,pagesize,refreshts,sort,tagid,brandid,topicid,promotionid}
  # ouput:
  # => {}
  def list

    return render :json=>Product.list_by_page({
        :page=>params[:page],
        :pagesize=>params[:pagesize],
        :type=>params[:type],
        :refreshts=>params[:refreshts],
        :tagid=>params[:tagid],
        :brandid=>params[:brandid],
        :topicid=>params[:topicid],
        :promotionid=>params[:promotionid],
        :storeid=>params[:storeid],
        :sortby=>params[:sortby]
      })
    
  end
  # search api always return json
  # input :page, pagesize
  def search
    
    return render :json=>Product.search_by_key({
      :page=>params[:page],
      :pagesize=>params[:pagesize],
      :term=>params[:term]
    })
  end

end
