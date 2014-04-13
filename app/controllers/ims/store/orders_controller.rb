# encoding: utf-8
class Ims::Store::OrdersController < Ims::Store::BaseController

  def index
    @orders = Ims::Store::Order.list(request)
  end

  def show

  end

end
