# encoding: utf-8
class Ims::CardOrdersController < Ims::BaseController
  layout "ims/user"

  def new
    @cards = Ims::Giftcard.items(request, {id: Ims::Giftcard::DEFAULT_ID})["data"]["items"]
  end

  # 自己购买
  def my_list
    @my = Ims::Giftcard.list(request, {type: 1, page: (params[:page] || 1)})
    respond_to do |format|
      format.html{}
      format.json{render "my_list"}
    end
  end

  # 好友赠送
  def received_list
    @received = Ims::Giftcard.list(request, {type: 2, page: (params[:page] || 1)})
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
    @notify_url = 'http://111.207.166.195/ims/payment/notify_giftcard'
    @time_val = Time.now
    
    package = {
      bank_type: "WX",
      body: "商品描述",
      fee_type: "1",
      input_charset: 'GBK',
      notify_url: @notify_url,
      out_trade_no: @out_trade_no,
      partner: Settings.wx.parterid,
      spbill_create_ip: request.remote_ip,
      total_fee: price.to_f * 100
    }
    string1 = ""; package.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
    sign_value = Digest::MD5.hexdigest("#{string1}&key=#{Settings.wx.parterkey}").upcase
    @package_val = "#{package.to_param}&sign=#{sign_value}"

    pay_sign = {
      appid: Settings.wx.appid, 
      appkey: Settings.wx.appkey,
      noncestr: @noncestr_val, 
      package: @package_val,
      timestamp: @time_val.to_i
    }
    string1 = ""; pay_sign.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
    @paySign_val = Digest::SHA1.hexdigest(string1)

    binding.pry

  end

  # 查询是否充值成功
  def check_status
    # API_NEED: 根据订单id查询是否充值成功
    result = Ims::UserApi.latest_giftcard(request, {"giftcardid" => params["giftcardid"], "timestamp" => params["timestamp"]})
    # TODO 上线前，删除下列代码
    render json: {result: {data: {charge_no: 114040224412}}}
    # TODO 上线前，开启下列代码
    # render json: {result: result}
  end

  def show
    @charge_no = params[:id]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息
    @card = Ims::Giftcard.detail(request, charge_no: @charge_no)["data"]
  end

end