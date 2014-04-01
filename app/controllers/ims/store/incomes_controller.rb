class Ims::Store::IncomesController < Ims::Store::BaseController

  def index

  end

  def my
    @income = Ims::Income.my(request)
  end

  def new
  end

  def create
    redirect_to my_ims_store_incomes_path
  end

  def list
    @list = Ims::Income.list(request)
  end

  def frozen
    @list = Ims::Income.frozen(request)
  end


end
