class Ims::Store::OrdersController < Ims::Store::BaseController

  def index
    @orders = Ims::Store::Order.list(request)["data"]["items"]
  end

  def show

  end

end
