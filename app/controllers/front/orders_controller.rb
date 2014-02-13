# encoding: utf-8
class Front::OrdersController < Front::BaseController
  before_filter :authenticate!

  def index
    options = {
      page: params[:page],
      pagesize: 10,
      type: params[:type].present? ? params[:type] : API::Order::TYPES[:unpaid],
    }
    result = API::Order.index(request, options)[:data]
    @orders = Kaminari.paginate_array(
      result[:items],
      total_count: result[:totalcount].to_i
    ).page(result[:pageindex]).per(result[:pagesize])
  end

  def create
    result = API::Order.create(request, order: params[:order])
    json   = result.slice(:isSuccessful, :statusCode, :message)
    if result[:isSuccessful]
      json[:data] = {
        order_no: result[:data][:orderno],
        payment_name: result[:data][:paymentname],
        payment_url: pay_front_order_url(result[:data][:orderno]),
        order_url: front_order_url(result[:data][:orderno])
      }
    end

    render json: json, callback: params[:callback]
  end

  def show
    result   = API::Order.show(request, orderno: params[:id])
    render_404(:html) and return unless result[:isSuccessful]

    @order   = result[:data]
    @product = @order['products'][0]
  end

  def destroy
    render json: API::Order.destroy(request, orderno: params[:id])
  end

  def new
    respond_to do |format|
      format.json {
        result = API::Order.new(request, productid: params[:product_id])
        render_500 { result['message'] } and return unless result[:isSuccessful]

        result[:data][:address] = API::Address.index(request, page: 1, pagesize: 1)[:data][:items][0]
        result[:data].delete(:dimension)
        result[:data][:salecolors].each_with_index do |color, index|
          resource = result[:data][:salecolors][index].delete(:resource)
          result[:data][:salecolors][index][:images_url] = resource.is_a?(Hash) ? middle_pic_url(resource) : ''
        end
        result[:data][:supportpayments] = if mobile_request?
          result[:data][:supportpayments].select { |r| r[:supportmobile] }
        else
          result[:data][:supportpayments].select { |r| r[:supportpc] }
        end
        
        render json: result, callback: params[:callback]
      }
      format.html {
        @invoices = API::Environment.supportinvoicedetails(request)[:data][:items]
      }
    end
  end

  # *input*
  # {
  #   productid: '商品id',
  #   desc: '商品描述',
  #   quantity: '数量',
  #   properties: {
  #     sizevalueid: '尺码主键',
  #     sizevaluename: '尺码描述',
  #     colorvalueid: '颜色主键',
  #     colorvaluename: '颜色描述'
  #   }
  # }
  def confirm
    @product = params[:product]
  end

  # *input*
  # {
  #   productid: 1,
  #   quantity: 1
  # }
  #
  # *output*
  # - success
  # {
  #   isSuccessful: true,                           // 判断是否操作成功
  #   statusCode: 200,
  #   message: '操作成功',                          // 提示信息
  #   data: {
  #     totalfee: 100,                              // 运费
  #     totalpoints: 100,                           // 总积分
  #     totalamount: 100,                           // 总金额
  #     extendprice: 100                            // 商品价格
  #   }
  # }
  # - fail
  # {
  #   isSuccessful: false,                          // 判断是否操作成功
  #   statusCode: 500,
  #   message: '操作失败',                          // 提示信息
  # }
  def computeamount
    render json: API::Order.computeamount(request, params.slice(:productid, :quantity)), callback: params[:callback]
  end

  def pay
    result  = API::Order.show(request, orderno: params[:id])

    if result[:isSuccessful]
      order   = result[:data]
      product = order['products'][0]

      if order['statust'].to_s == API::Order::STATUSES[:unpaid].to_s
        case order['paymentcode'].to_s
        when Settings.payment_code.alipay.to_s then
          req_data = {
            subject:        product['productname'],
            out_trade_no:   order['orderno'],
            total_fee:      order['totalamount']
          }

          if mobile_request?
            req_data[:out_user]      = current_user.id
            req_data[:call_back_url] = payment_callback_url
            req_data[:notify_url] = Settings.alipay_notify_url
            redirect_to Alipay::Services::Direct::Payment::Wap.url(req_data: req_data)
          else
            req_data[:return_url]    = payment_callback_url
            req_data[:body]          = product['productdesc']
            req_data[:show_url]      = product_url(product['productid'])
            req_data[:notify_url] = Settings.alipay_pc_notify_url
            redirect_to Alipay::Services::Direct::Payment::Web.url(req_data)
          end
        when Settings.payment_code.wxpay.to_s then
          pay_url = API::Order.wxpay_url(request,{orderno:params[:id],clientip:request.remote_ip,returnurl:payment_callback_url})
          redirect_to pay_url[:data][:payurl]
        else
          @message = "支付方式不支持！"
        end
      else
        @message = "支付失败，该订单当前状态为#{order[:status]}，不能支付！"
      end
    else
      @message = "支付失败，#{result[:message]}"
    end
  end

  # {
  #   "out_trade_no"  => "113101408139",
  #   "request_token" => "requestToken",
  #   "result"        => "success",
  #   "trade_no"      => "2013101446999897",
  #   "sign"          => "3d767613bb0cfc8dc846424461676d63",
  #   "sign_type"     => "MD5"
  # }
  def pay_callback
    redirect_to front_order_path(params['out_trade_no'])
  end
end
