# encoding: utf-8
class Ims::FavoritesController < Ims::BaseController

  def list
    @title = "我的收藏"
    @search_store = Ims::UserApi.favor_store(request, {page: (params[:page] || 1), pagesize: 10} )
    @stores = @search_store["data"]["items"]
    @search_combo = Ims::UserApi.favor_combo(request, {page: (params[:page] || 1), pagesize: 10} )
    @combos = @search_combo["data"]["items"]
  end

  def stores_list
    @title = "我的收藏"
    @search_store = Ims::UserApi.favor_store(request, {page: (params[:page] || 1), pagesize: 10} )
    @stores = @search_store["data"]["items"]
  end

  def combos_list
    @title = "我的收藏"
    @search_combo = Ims::UserApi.favor_combo(request, {page: (params[:page] || 1), pagesize: 10} )
    @combos = @search_combo["data"]["items"]
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
