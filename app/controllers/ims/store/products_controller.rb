class Ims::Store::ProductsController < Ims::Store::BaseController

  def index

  end

  def show

  end

  def new
    @brands = Ims::Brand.list(request)
    binding.pry
  end

  def create
    redirect_to ims_store_products_path
  end

  def tutorials
  end

end