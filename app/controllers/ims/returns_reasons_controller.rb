# encoding: utf-8

class Ims::ReturnsReasonsController < Ims::BaseController

  def new
    @reasons = API::Environment.supportrmareasons(request, pagesize: 10)[:data][:items]
  end

  def create
    reason = API::Rma.create(request, orderno: params[:order_id], reason: params[:reason], rmareason: params[:reason_id])
    if reason[:isSuccessful]
      redirect_to result_ims_order_returns_reasons_path(params[:order_id])
    else
      redirect_to new_ims_order_returns_reason_path(params[:order_id])
    end
  end

  def cancel
    rmano = API::Rma.destroy(request, rmano: params[:id])
    render json: {status: rmano[:isSuccessful]}.to_json
  end
end
