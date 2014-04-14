# encoding: utf-8
class Ims::CombosController < Ims::BaseController
  layout "store"
  
  def show
    @remote_combo = Ims::Combo.show(request, {:id => params[:id]})
    @private_to = params[:private_to]
    @store_id = params[:store_id]
    @title = "搭配展示"
    @can_share == true
  end
end