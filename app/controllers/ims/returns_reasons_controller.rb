class Ims::ReturnsReasonsController < Ims::BaseController

  def new
  end

  def create
    redirect_to result_ims_order_returns_reasons_path("order_id")
  end
end