# encoding: utf-8
class Mini::Store::OrdersController < Mini::Store::BaseController

  def index
    @orders = Mini::Store::Order.list(request)
  end

  def show

  end

end
