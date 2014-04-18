# encoding: utf-8
class Mini::ReturnsReasonsController < Mini::BaseController

  def new
    @reasons = API::Environment.supportrmareasons(request, pagesize: 10)[:data][:items]
  end

  def create
    reason = API::Rma.create(request, orderno: params[:order_id], reason: params[:reason], rmareason: params[:reason_id])
    if reason[:isSuccessful]
      redirect_to result_mini_order_returns_reasons_path(params[:order_id])
    else
      redirect_to new_mini_order_returns_reason_path(params[:order_id])
    end
  end

  def cancel
    rmano = API::Rma.destroy(request, rmano: params[:id])
    render json: {status: rmano[:isSuccessful]}.to_json
  end
end