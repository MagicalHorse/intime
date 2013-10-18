class Front::StoresController < Front::BaseController

  def show
    @promotions = Stage::Promotion.list(pagesize: 3, storeid: params[:id])
    @products   = Stage::Product.item_list(pagesize: 3, storeid: params[:id])
  end

  def index
  end
end
