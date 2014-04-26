# encoding: utf-8
class V22::PromotionController < PromotionController
  # list api always return json
  # input: 
  # => {page,pagesize,refreshts,sort,lng,lat}
  # => sort : 1   --- newest 3: ---neareast
  # ouput:
  # => {}
  def list
   
   return render :json=>Promotion.list_by_page({
      :page=>params[:page],
      :pagesize=>params[:pagesize],
      :type=>params[:type],
      :refreshts=>params[:refreshts],
      :sort=>params[:sort],
      :lng=>params[:lng],
      :lat=>params[:lat],
      :storeid=>params[:storeid]
    })
    
    
  end
end
