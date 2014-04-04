# encoding: utf-8
class Ims::CardOrdersController < Ims::BaseController
  layout "ims/user"

  def new
    @cards = Ims::Giftcard.items(request, {id: Ims::Giftcard::DEFAULT_ID})["data"]["items"]
  end

  # 自己购买
  def my_list
    @my = Ims::Giftcard.list(request, type: 1)
    respond_to do |format|
      format.html{}
      format.json{render "my_list"}
    end
  end

  # 好友赠送
  def received_list
    @received = Ims::Giftcard.list(request, type: 2)
    respond_to do |format|
      format.html{}
      format.json{render "received_list"}
    end
  end

  # 付款礼品卡
  def create
    @card_id, price = params[:money].split(",")
    #订单号 {子礼品卡编码}+{-}+{用户 id}+{-}+{来源店铺 id}
    @out_trade_no = "#{@card_id}-#{current_user.id}" 
    @out_trade_no = "#{@out_trade_no}-#{params[:store_id]}" if params[:store_id].present?
    @noncestr_val = (1..9).map{ ('a'..'z').to_a.sample }.join('') # 随机码
    # TODO 上线前，修改为正式地址
    @notify_url = 'http://joey.ngrok.com/ims/payment/notify_giftcard'
    @time_val = Time.now
    @package_val = {
      bank: "WX",
      body: "商品描述",
      partner: Settings.wx.partner_id,
      out_trade_no: @out_trade_no,
      total_fee: price,
      fee_type: 1,
      notify_url: @notify_url,
      spbill_create_ip: request.remote_ip,
      time_start: @time_val.strftime('%Y%m%d%H%m%S'),
      time_expire: 1.hours.from_now.strftime('%Y%m%d%H%m%S'),
      transport_fee: 0,
      product_fee: price,
      input_charset: 'UTF-8' 
    }
    @paySign_val = Digest::SHA1.hexdigest({appid: Settings.wx.appid, timestamp: @time_val.to_i, noncestr: @noncestr_val, package: @package_val.to_param, appkey: Settings.wx.appsecret}.to_param)
  end

  # 查询是否充值成功
  def check_status
    # API_NEED: 根据订单id查询是否充值成功
    result = Ims::UserApi.latest_giftcard(request, {"giftcardid" => params["giftcardid"], "timestamp" => params["timestamp"]})
    render json: {result: result}
  end

  def show
    @charge_no = params[:id]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息
    @card = Ims::Giftcard.detail(request, charge_no: @charge_no)["data"]
  end

end