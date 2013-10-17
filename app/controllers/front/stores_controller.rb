class Front::StoresController < Front::BaseController

  def show
    @promotions = Stage::Promotion.list(pagesize: 3, storeid: params[:id])
    #@products   = Stage::Product.list()
  end

  def index
  end
end
