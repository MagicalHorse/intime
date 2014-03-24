# encoding: utf-8
class Ims::CardOrdersController < Ims::BaseController

  def index
    # API_NEED: 获取礼品卡订单的列表
  end

  # 付款礼品卡
  def create
    # API_NEED: 创建购买礼品卡的订单
    API::Giftcard.purchase(request, {price: params[:price]})

    @out_trade_no = 'AF135GBGQS' #订单号
    @transport_fee = 23.00 #运费
    @product_fee = params[:price] #售价
    @total_fee = params[:price] #合计
    @noncestr_val = (1..9).map{ ('a'..'z').to_a.sample }.join('') #随机码
    @notify_url = 'http://freebird.ngrok.com/ims/card_orders/paid'
    @package_val = { bank: "WX",  body: "商品描述",  partner: Settings.wx.partner_id,  out_trade_no: 0,  total_fee: 0,  fee_type: 1,   notify_url: @notify_url,  spbill_create_ip: request.remote_ip,  time_start: Time.now.strftime('%Y%m%d%H%m%S'),  time_expire: 1.hours.from_now.strftime('%Y%m%d%H%m%S'),  transport_fee: 0,  product_fee: 0,  input_charset: 'UTF-8' }.to_param
    @paySign_val = Digest::SHA1.hexdigest({appid: Settings.wx.appid, timestamp: @timestamp_val, noncestr: @noncestr_val, package: @package_val, appkey: Settings.wx.appsecret}.to_param)
  end

  # 查询是否充值成功
  def check_status
    # API_NEED: 根据订单id查询是否充值成功
    render json: {result: true}

  end

  def show
    # API_NEED: 获取某张礼品卡订单的详情
    @price = 500
    @code = 'AF135GBGQS'
  end
  
end