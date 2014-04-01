class Ims::Store::IncomesController < Ims::Store::BaseController

  def index

  end

  def my
    @income = Ims::Income.my(request)
  end

  def new
  end

  def create
    income = Ims::Income.apply(request, {bank: params[:bank], card_no: params[:card_no], amount: params[:amount], user_name: params[:user_name]})
    if income[:isSuccessful]
      redirect_to my_ims_store_incomes_path
    else
      render :action => :new
    end  
  end

  def list
    @list = Ims::Income.list(request)
  end

  def frozen
    @list = Ims::Income.frozen(request)
  end


end
