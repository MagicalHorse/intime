# encoding: utf-8

class Ims::CardOrdersController < Ims::BaseController
  layout "ims/user"

  def new
    @cards = Ims::Giftcard.items(request, {id: Ims::Giftcard::DEFAULT_ID})["data"]["items"]
    @is_weixin = session[:itpm] != "1"
  end

  def list
    @title = "交易记录"
    @my = Ims::Giftcard.list(request, {type: 1, page: (params[:page] || 1), pagesize: 10})
    @received = Ims::Giftcard.list(request, {type: 2, page: (params[:page] || 1), pagesize: 10})
  end

  # 自己购买
  def my_list
    @title = "自己购买"
    @my = Ims::Giftcard.list(request, {type: 1, page: (params[:page] || 1), pagesize: 10})
    respond_to do |format|
      format.html{}
      format.json{render "my_list"}
    end
  end

  # 好友赠送
  def received_list
    @title = "好友赠送"
    @received = Ims::Giftcard.list(request, {type: 2, page: (params[:page] || 1), pagesize: 10})
    respond_to do |format|
      format.html{}
      format.json{render "received_list"}
    end
  end

  # 付款礼品卡
  def create
    @card_id, price = params[:money].split(",")

    if params[:pay_type] == "wechat"
      weixin_key
      #订单号 {子礼品卡编码}+{-}+{用户 id}+{-}+{来源店铺 id}
      @out_trade_no = "#{Time.now.to_i}#{rand(99).to_s.rjust(2,"0")}-#{@card_id}-#{current_user.id}"
      @out_trade_no = "#{@out_trade_no}-#{params[:store_id]}" if params[:store_id].present?
      @noncestr_val = (1..9).map{ ('a'..'z').to_a.sample }.join('') # 随机码
      @notify_url = "http://#{Settings.wx.notifydomain}/ims/payment/notify_giftcard"
      @time_val = Time.now
      package = {
        bank_type: "WX",
        body: "礼品卡",
        fee_type: "1",
        input_charset: 'GBK',
        notify_url: @notify_url,
        out_trade_no: @out_trade_no,
        partner: @weixin_key[:parter_id],
        spbill_create_ip: request.remote_ip,
        total_fee: (BigDecimal(price) * 100).to_i
      }
      string1 = ""; package.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
      sign_value = Digest::MD5.hexdigest("#{string1}&key=#{@weixin_key[:parter_key]}").upcase
      @package_val = "#{package.to_param}&sign=#{sign_value}"

      pay_sign = {
        appid: @weixin_key[:app_id],
        appkey: @weixin_key[:pay_signkey],
        noncestr: @noncestr_val,
        package: @package_val,
        timestamp: @time_val.to_i
      }
      string1 = ""; pay_sign.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
      @paySign_val = Digest::SHA1.hexdigest(string1)
    else
      alipay_key
      out_trade_no = "#{Time.now.to_i}#{rand(99).to_s.rjust(2,"0")}-#{@card_id}-#{current_user.id}"
      out_trade_no = "#{out_trade_no}-#{params[:store_id]}" if params[:store_id].present?
      req_data = {
        subject:        '礼品卡',
        out_trade_no:   out_trade_no,
        total_fee:      price,
        out_user:       current_user.id,
        call_back_url:  "http://#{Settings.default_url_options.host}#{ims_card_orders_pay_path( card_id: @card_id, time_val: Time.now.to_i )}" ,
        notify_url:     "http://#{Settings.wx.notifydomain}/ims/payment/notify_giftcard_from_ali",
        seller_account_name:  @alipay_key[:seller_account]
      }
      Alipay.logger.debug("-----> #{Time.now.strftime('%y-%m-%d %H:%M:%S')} notify http://#{Settings.wx.notifydomain}/ims/payment/notify_giftcard_from_ali")
      @url = Alipay::Services::Direct::Payment::Wap.url({partner: @alipay_key[:partner_id], req_data: req_data}, @alipay_key[:md5_key])
    end

  end

  # 查询是否充值成功
  def check_status
    # API_NEED: 根据订单id查询是否充值成功
    result = Ims::UserApi.latest_giftcard(request, {"giftcardid" => params["giftcardid"], "timestamp" => params["timestamp"]})
    render json: {result: result}
  end

  def show
    @title = "订单详情"
    @charge_no = params[:id]
    current_user.other_phone = nil
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息
    @card = Ims::Giftcard.detail(request, charge_no: @charge_no)["data"] || {}
  end

end
