# encoding: utf-8
class Ims::CardOrdersController < Ims::BaseController
  layout "ims/user"

  # 我的礼品卡
  def index
    # API_NEED: 获取礼品卡订单的列表
    @my = Ims::Giftcard.list(request, type: 1)
    @recieved = Ims::Giftcard.list(request, type: 2)
  end

  # 付款礼品卡
  def create
    @out_trade_no = 'AF135GBGQS' #订单号
    @transport_fee = 0 #运费
    @product_fee = params[:price] #售价
    @total_fee = params[:price] #合计
    @noncestr_val = (1..9).map{ ('a'..'z').to_a.sample }.join('') #随机码
    @notify_url = 'http://joey.ngrok.com/ims/payment/notify_giftcard'
    @package_val = { bank: "WX",  body: "商品描述",  partner: Settings.wx.partner_id,  out_trade_no: @out_trade_no,  total_fee: @total_fee,  fee_type: 1,   notify_url: @notify_url,  spbill_create_ip: request.remote_ip,  time_start: Time.now.strftime('%Y%m%d%H%m%S'),  time_expire: 1.hours.from_now.strftime('%Y%m%d%H%m%S'),  transport_fee: @transport_fee,  product_fee: @product_fee,  input_charset: 'UTF-8' }.to_param
    @paySign_val = Digest::SHA1.hexdigest({appid: Settings.wx.appid, timestamp: @timestamp_val, noncestr: @noncestr_val, package: @package_val, appkey: Settings.wx.appsecret}.to_param)
  end

  # 查询是否充值成功
  def check_status
    # API_NEED: 根据订单id查询是否充值成功
    render json: {result: true}
  end

  def show
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息

    # 1、礼品卡编号、评论内容、礼品卡赠送的手机号、赠送礼品卡的人名
    # 2、礼品卡状态：已转赠、已经收取、已经拒收、未操作
    # 3、礼品卡价值
    
    @card = {}
    @price = 500
    @charge_no = 'AF135GBGQS'
  end

end