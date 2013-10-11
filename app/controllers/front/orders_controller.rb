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
    #render json: API::Order.new(request, productid: params[:product_id])
  end

#  {
#    products: [{
#      productid: 882,
#      desc: '测试',
#      quantity: 1,
#      memo: "第一单",
#      properties: { sizevalueid: 145, sizevaluename: "MXXL", colorvalueid: 144, colorvaluename: "白色"},
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
end
