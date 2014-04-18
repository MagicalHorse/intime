# encoding: utf-8
class Mini::FavoritesController < Mini::BaseController

  def stores_list
    @stores = Mini::UserApi.favor_store(request, {page: (params[:page] || 1), pagesize: 10} )["data"]["items"]
  end

  def combos_list
    @combos = Mini::UserApi.favor_combo(request, {page: (params[:page] || 1), pagesize: 10} )["data"]["items"]
  end
  
  def favor
    # API_NEED: 添加到列表
    # 添加收藏的ajax
    Mini::UserApi.favor(request, type: params[:type], id: params[:id])
    render nothing: true
  end
  
  def unfavor
    # API_NEED: 删除收藏
    # 删除收藏的ajax
    Mini::UserApi.unfavor(request, type: params[:type], id: params[:id])
    render nothing: true
  end
end