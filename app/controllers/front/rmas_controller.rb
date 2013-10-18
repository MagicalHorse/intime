class Front::RmasController < Front::BaseController
  respond_to :html, :json
  before_filter :authenticate!

  def index
    options = { page: params[:page], pagesize: 10 }
    result  = API::Rma.index(request, options)[:data]
    @rmas   = Kaminari.paginate_array(
      result[:items],
      total_count: result[:totalcount].to_i
    ).page(result[:pageindex]).per(result[:pagesize])
  end

  def new
    result   = API::Order.show(request, orderno: params[:order_id])
    render_404(:html) and return unless result[:isSuccessful]

    @order   = result[:data]
    @product = @order['products'][0]
    respond_with @order
  end

  def create
    render json: API::Rma.create(request, params.slice(:orderno, :reason, :products))
  end

  def show
    render json: API::Rma.show(request, rmano: params[:id])
  end

  def order_index
    options = { page: params[:page], pagesize: 10 }
    result  = API::Rma.order_index(request, options)[:data]
    @orders = Kaminari.paginate_array(
      result[:items],
      total_count: result[:totalcount].to_i
    ).page(result[:pageindex]).per(result[:pagesize])
    respond_with @orders
  end
end
