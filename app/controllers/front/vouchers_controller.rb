# encoding: utf-8
class Front::VouchersController < Front::BaseController
  before_filter :authenticate!

  def index
    @recent_vouchers  = API::Voucher.index(request, params.slice(:page).merge(type: 1, pagesize: 20))['data']
    @news_vouchers    = API::Voucher.index(request, params.slice(:page).merge(type: 2, pagesize: 20))['data']
    @expire_vouchers  = API::Voucher.index(request, params.slice(:page).merge(type: 3, pagesize: 20))['data']

    @vouchers = case params[:type].to_i
                when 2
                  @news_vouchers
                when 3
                  @expire_vouchers
                else
                  @recent_vouchers
                end

    @vouchers = Kaminari.paginate_array(
      @vouchers[:items],
      total_count: @vouchers[:totalcount].to_i
    ).page(@vouchers[:pageindex]).per(@vouchers[:pagesize])
  end

  def show
    @voucher = API::Voucher.show(request, storecouponid: params[:id])[:data]
  end

  def exchange_info
    @storepromotion = Stage::Storepromotion.list(pagesize: 1)[0]
    @card = API::Card.detail(request)[:data]
    point_list
  end

  def binding_card
    redirect_to exchange_info_front_vouchers_path if current_user.isbindcard
  end

  def void
    result = API::Voucher.void(request, storecouponid: params[:id])

    result[:isSuccessful] ? redirect_to(front_vouchers_path) : redirect_to(front_voucher_path(params[:id]))
  end

  def bindcard
    result = API::Card.bind(request, params.slice(:cardno, :password))

    if result[:isSuccessful]
      current_user.assign_attributes(isbindcard: true, cardno: result['data']['cardno'])

      flash[:notice] = '银泰卡绑定成功'
      redirect_to exchange_info_front_vouchers_path
    else
      flash[:notice] = '银泰卡绑定失败，请确认卡号和密码。'
      redirect_to binding_card_front_vouchers_path
    end
  end

  protected

  def point_list
    result = API::Point.index(request, params.slice(:page).merge(pagesize: 10))['data']

    @records = Kaminari.paginate_array(
      result['points'],
      total_count: result['totalcount'].to_i
    ).page(result['pageindex']).per(result['pagesize'])
  end
end
