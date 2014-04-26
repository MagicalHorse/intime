# encoding: utf-8
class Front::RmasController < Front::BaseController
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
    @reasons = format_items(API::Environment.supportrmareasons(request)[:data], :page, :pagesize, :totalcount, :totalpaged)[:datas]
  end

  def create
    product = JSON.load(params[:rma][:products])[0]
    product['desc'] = product['productdesc']
    product['quantity'] = params[:rma][:quantity]
    product['properties'] = product.slice('sizevalueid', 'sizevalue', 'colorvalueid', 'colorvalue')
    options = params[:rma].slice(:orderno, :reason, :rmareason).merge(products: [product.slice('productid', 'desc', 'quantity', 'properties')].to_json)
    logger.debug "------> #{options}"
    render json: API::Rma.create(request, options)
  end

  def show
    result = API::Rma.show(request, rmano: params[:id])
    render_404(:html) and return unless result[:isSuccessful]

    @rma     = result[:data]
    @product = @rma['products'][0] rescue {}
  end

  def order_index
    options = { page: params[:page], pagesize: 10 }
    result  = API::Rma.order_index(request, options)[:data]
    @orders = Kaminari.paginate_array(
      result[:items],
      total_count: result[:totalcount].to_i
    ).page(result[:pageindex]).per(result[:pagesize])
  end

  def edit
    result = API::Rma.show(request, rmano: params[:id])
    render_404(:html) and return unless result[:isSuccessful]

    @rma     = result[:data]
    @product = @rma['products'][0] rescue {}
    #@shipvias = format_items(API::Environment.supportshipvias(request)[:data], :page, :pagesize, :totalcount, :totalpaged)[:datas]
  end

  def update
    render json: API::Rma.update(request, params[:rma].merge(rmano: params[:id]))
  end

  def destroy
    result = API::Rma.destroy(request, rmano: params[:id])

    if result[:isSuccessful]
      redirect_to order_index_front_rmas_path, notice: result['message']
    else
      redirect_to order_index_front_rmas_path, alert: result['message']
    end
  end
end
