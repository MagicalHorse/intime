# encoding: utf-8
class Front::StorepromotionsController < Front::BaseController
  before_filter :authenticate!
  before_filter :binding_card, except: [:index]

  def index
    @storepromotions = Stage::Storepromotion.list(params.slice(:page))
  end

  def show
    @storepromotion = Stage::Storepromotion.fetch(params[:id])
  end

  def amount
    amount = API::Storepromotion.amount(request, storepromotionid: params[:id], points: params[:points])[:data]

    render json: {amount: amount.nil? ? 0 : amount[:amount]}
  end

  def exchange
    @result = API::Storepromotion.exchange(request, params.slice(:points, :identityno, :storeid).merge(storepromotionid: params[:id]))

    respond_to { |format| format.js }
  end

  protected
  def binding_card
    unless current_user.isbindcard
      flash[:notice] = '请先绑定银泰卡'
      redirect_to binding_card_front_vouchers_path
    end
  end
end
