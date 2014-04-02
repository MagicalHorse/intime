class Ims::FavoritesController < Ims::BaseController
  def index
    # API_NEED: 收藏列表
    @stores = Ims::UserApi.favor_store(request)["data"]["items"] || []
    @combos = Ims::UserApi.favor_combo(request)["data"]["items"] || []
  end
  
  def create
    # API_NEED: 添加到列表
    # 添加收藏的ajax
    Ims::UserApi.favor(request, type: params[:type], id: params[:id])
  end
  
  def destroy
    # API_NEED: 删除收藏
    # 删除收藏的ajax
    Ims::UserApi.unfavor(request, type: params[:type], id: params[:id])
  end
end