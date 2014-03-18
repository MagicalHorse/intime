class Ims::Store::ProductsController < Ims::Store::BaseController

  def index

  end

  def new

  end

  def create
    redirect_to ims_store_products_path
  end

end