# encoding: utf-8
class Front::CouponsController < Front::BaseController
  before_filter :authenticate!

  def index
    @recent_coupons = API::Coupon.index(request, params.slice(:page).merge(type: 1, pagesize: 10))[:data]
    @news_coupons   = API::Coupon.index(request, params.slice(:page).merge(type: 2, pagesize: 10))[:data]
    @expire_coupons = API::Coupon.index(request, params.slice(:page).merge(type: 3, pagesize: 10))[:data]

    @coupons = case params[:type].to_i
               when 2
                 @news_coupons
               when 3
                 @expire_coupons
               else
                 @recent_coupons
               end

    @coupons = Kaminari.paginate_array(
      @coupons[:couponcodes],
      total_count: @coupons[:totalcount].to_i
    ).page(@coupons[:pageindex]).per(@coupons[:pagesize])
  end
end
