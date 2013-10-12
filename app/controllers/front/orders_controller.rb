# encoding: utf-8
class Front::OrdersController < Front::BaseController
  before_filter :authenticate!

  def index
    options = {
      page: params[:page],
      pagesize: 10,
      type: params[:type]
    }
    render json: API::Order.index(request, options)
  end

  def create
    render json: API::Order.create(request, order: params[:order].to_json)
  end

  def show
    render json: API::Order.show(request, orderno: params[:id])
  end

  def destory
    render json: API::Order.show(request, orderno: params[:id])
  end

  def update
    render json: API::Order.update(request, orderno: params[:id], reason: params[:reason], products: params[:products].to_json)
  end

  def new
    result = API::Order.new(request, productid: params[:product_id])
    check_api_result(result, :html)
    @product = result[:data]
  end

#  ORDER = {
#    products: [{
#      productid: 976,
#      desc: '100%棉，拼接设计，让沉闷的黑色舔了一抹活泼色彩',
#      quantity: 1,
#      properties: { sizevalueid: 249, sizevaluename: "S", colorvalueid: 248, colorvaluename: "黑色"},
#    }],
#    needinvoice: false,
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
#  {"data"=>{"orderno"=>"113101153513", "totalamount"=>999.0},
#   "isSuccessful"=>true,
#   "statusCode"=>200,
#   "message"=>"操作成功！"}
end
