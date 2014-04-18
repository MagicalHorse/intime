# encoding: utf-8
class Mini::StoresController < Mini::BaseController
  layout "store"
  
  def show
    @store = Mini::Store.show(request, id: params[:id])
    @title = "店铺展示"
    @can_share = true
  end
end