class Ims::Store::IncomesController < Ims::Store::BaseController

  def index

  end

  def my
  end

  def new
  end

  def create
    redirect_to my_ims_store_incomes_path
  end

  def list
    render :index
  end

end