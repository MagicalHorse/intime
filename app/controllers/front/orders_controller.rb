class Front::OrdersController < Front::BaseController

  def index
    options = {
      page: params[:page],
      pagesize: 10,
      type: params[:type]
    }
    result = API::Order.post(request, options)
    render_500 and return if !result[:isSuccessful]
    orders, total_count, page, per_page = result[:data].values_at(:items, :totalcount, :pagesize, :pageindex)
    render json: Kaminari.paginate_array(orders, total_count: total_count).page(page).per(per_page)
  end

  def create
  end
end
