# encoding: utf-8
class Ims::FavoritesController < Ims::BaseController

  def list
    @stores = Ims::UserApi.favor_store(request, {page: (params[:page] || 1), pagesize: 10} )["data"]["items"]
    @combos = Ims::UserApi.favor_combo(request, {page: (params[:page] || 1), pagesize: 10} )["data"]["items"]
  end

  def stores_list
    @stores = Ims::UserApi.favor_store(request, {page: (params[:page] || 1), pagesize: 10} )["data"]["items"]
  end

  def combos_list
    @combos = Ims::UserApi.favor_combo(request, {page: (params[:page] || 1), pagesize: 10} )["data"]["items"]
  end
  
  def favor
    # API_NEED: 添加到列表
    # 添加收藏的ajax
    Ims::UserApi.favor(request, type: params[:type], id: params[:id])
    render nothing: true
  end
  
  def unfavor
    # API_NEED: 删除收藏
    # 删除收藏的ajax
    Ims::UserApi.unfavor(request, type: params[:type], id: params[:id])
    render nothing: true
  end
end