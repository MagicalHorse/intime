# encoding: utf-8
class Front::OrdersController < Front::BaseController
  before_filter :authenticate!

  def index
    options = {
      page: params[:page],
      pagesize: 10,
      type: params[:type]
    }
    render json: @orders = format_items(API::Order.index(request, options)[:data])
  end

  def create
    result = API::Order.create(request, order: params[:order])
    json   = result.slice(:isSuccessful, :statusCode, :message)
    if result[:isSuccessful]
      json[:data] = {
        order_no: result[:data][:orderno],
        payment_name: result[:data][:paymentname],
        payment_url: '',
        order_url: front_order_url(result[:data][:orderno])
      }
    end

    render json: json
  end

  def show
    result   = API::Order.show(request, orderno: params[:id])
    render_404(:html) and return unless result[:isSuccessful]

    @order   = result[:data]
    @product = @order['products'][0]
  end

  def destory
    render json: API::Order.show(request, orderno: params[:id])
  end

  def update
    render json: API::Order.update(request, orderno: params[:id], reason: params[:reason], products: params[:products].to_json)
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
        render json: result
      }
      format.html
    end
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
    render json: API::Order.computeamount(request, params.slice(:productid, :quantity))
  end

  def pay
    result  = API::Order.show(request, orderno: params[:id])

    if result[:isSuccessful]
      order   = result[:data]
      product = order['products'][0]

      if order['statust'].to_s == API::Order::STATUST[:unpaid].to_s
        req_data = {
          subject:        product['productname'],
          out_trade_no:   order['orderno'],
          total_fee:      0.01,#order['totalamount'],
          call_back_url:  payment_callback_url,
          notify_url:     'http://apis.youhuiin.com/api/payment/notify',
          out_user:       current_user.id
        }
        redirect_to Alipay::Services::Direct::Payment::Wap.url(req_data: req_data)
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

#  {
#    products: [{
#      productid: 976,
#      desc: '100%棉，拼接设计，让沉闷的黑色舔了一抹活泼色彩',
#      quantity: 1,
#      properties: { sizevalueid: 533, sizevaluename: "L", colorvalueid: 531, colorvaluename: "红色"},
#    }],
#    needinvoice: true,
#    invoicetitle: '发票抬头',
#    invoicedetail: '发票明细',
#    memo: '订单备注',
#    shippingaddress: {
#      shippingcontactperson: "vg",
#      shippingcontactphone:"1352400000",
#      shippingzipcode: "200184",
#      shippingaddress: "上海市长宁区什么路"
#    },
#    payment: {
#      paymentcode: "1001",
#      paymentname: "货到付款"
#    }
#  }
#
#  {"data"=>
#   {"orderno"=>"113101278125",
#    "totalamount"=>999.0,
#    "paymentcode"=>"1001",
#    "paymentname"=>"������������"},
#    "isSuccessful"=>true,
#    "statusCode"=>200,
#    "message"=>"操作成功！
end
