class Front::StorepromotionsController < Front::BaseController

  def index
    @storepromotions = Stage::Storepromotion.list(params.slice(:page))
  end

  def show
    @storepromotion = Stage::Storepromotion.fetch(params[:id])
  end

  def amount
    amount = API::Storepromotion.amount(request, storepromotionid: params[:id], points: params[:points])[:data]

    render json: {amount: amount[:amount]}
  end

  def exchange
    @result = API::Storepromotion.exchange(request, params.slice(:points, :identityno, :storeid).merge(storepromotionid: params[:id]))

    respond_to do |format|
      format.js
    end
  end
end
