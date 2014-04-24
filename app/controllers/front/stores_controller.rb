# encoding: utf-8
class Front::StoresController < Front::BaseController

  def show
    @store      = Stage::Store.fetch(params[:id])
    @promotions = Stage::Promotion.list(pagesize: 3, storeid: params[:id])
    @products   = Stage::Product.item_list(pagesize: 3, storeid: params[:id])
  end

  def index
  end

  def promotions
  end
end
