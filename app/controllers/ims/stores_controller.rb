# encoding: utf-8

class Ims::StoresController < Ims::BaseController
  layout "ims/store"


  def show
    @store = Ims::Store.show(request, id: params[:id])
    @title = "店铺展示"
    @can_share = true
    @template_id = @store[:data][:template_id]
    session[:store_id] = @store[:data][:id]
  end

end
