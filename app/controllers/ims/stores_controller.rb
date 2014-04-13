# encoding: utf-8
class Ims::StoresController < Ims::BaseController
  layout "store"
  
  def show
    @store = Ims::Store.show(request, id: params[:id])
    @title = "店铺展示"
  end
end