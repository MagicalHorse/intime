class Ims::Store::OrdersController < Ims::Store::BaseController

  def index
    @orders = Ims::Order.my(request)["data"]["items"]
  end

  def show

  end

end
