# encoding: utf-8

class Ims::OrdersController < Ims::BaseController

  layout :set_layout

  def index
    @search = Ims::Order.my(request, page: params[:page], pagesize: params[:per_page] || 10)
    @orders = @search["data"]["items"]
    @title = "我的订单"

    respond_to do |format|
      format.html{}
      format.json{render "list"}
    end
  end

  def new
    @title = "商品购买"
    if params[:product_id].present?
      @product = API::Order.new(request, productid: params[:product_id])[:data]
      @salecolors = @product[:salecolors]
      @sizes = @salecolors.try(:first).try(:[], :sizes)
      @products = [@product]
      @order = API::Order::computeamount(request, productid: params["product_id"], quantity: 1)[:data]
    elsif params[:combo_id].present?
      @products = Ims::Order.new(request, id: params[:combo_id])[:data][:items]
      @order = Ims::Order::computeamount(request, combo_id: params["combo_id"], quantity: 1)[:data]
    end

    @contact = Ims::User.latest_address(request, params)[:data]

    @timeStamp_val = Time.now.to_i
    @nonceStr_val = ("a".."z").to_a.sample(9).join('')
    access_token  = cookies[:user_access_token]
    sign = {
      accesstoken: access_token,
      appid: Settings.wx.appid,
      noncestr: @nonceStr_val,
      timestamp: @timeStamp_val,
      url: request.original_url
    }
    string1 = ""; sign.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
    @addrSign_val = Digest::SHA1.hexdigest(string1)
  end

  def show
    @order = Ims::Order.detail(request, {orderno: params["id"]})["data"]
    @title = "订单详情"
    @current_rmas = @order[:rmas].find{|rmas| rmas[:canvoid]}
    respond_to do |format|
      format.html{}
      format.json{render json: @order}
    end
  end

  def create
    @order = API::Order::create(request, order: params[:order].to_json)
    if @order[:isSuccessful]
      render json: {status: true, data: @order[:data]}.to_json
    else
      render json: {status: false, message: @order[:message]}.to_json
    end
  end

  def payments
    @orderno = params[:id]
    @from_page = params[:from_page]
    # price = 0.01
    price = params[:money]
    # @card_id, price = params[:money].split(",")
    #订单号 {子礼品卡编码}+{-}+{用户 id}+{-}+{来源店铺 id}
    @out_trade_no = @orderno
    @noncestr_val = (1..9).map{ ('a'..'z').to_a.sample }.join('') # 随机码
    @notify_url = "http://#{Settings.wx.notifydomain}/ims/payment/notify"
    @time_val = Time.now

    package = {
      bank_type: "WX",
      body: @orderno,
      fee_type: "1",
      input_charset: 'GBK',
      notify_url: @notify_url,
      out_trade_no: @out_trade_no,
      partner: Settings.wx.parterid,
      spbill_create_ip: request.remote_ip,
      total_fee:  (BigDecimal(price) * 100).to_i
    }
    string1 = ""; package.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
    sign_value = Digest::MD5.hexdigest("#{string1}&key=#{Settings.wx.parterkey}").upcase
    @package_val = "#{package.to_param}&sign=#{sign_value}"

    pay_sign = {
      appid: Settings.wx.appid,
      appkey: Settings.wx.paysignkey,
      noncestr: @noncestr_val,
      package: @package_val,
      timestamp: @time_val.to_i
    }
    string1 = ""; pay_sign.each{|k, v| string1 << "#{k}=#{v}&"}; string1.chop!
    @paySign_val = Digest::SHA1.hexdigest(string1)

  end

  def change_state
    order = API::Order.destroy(request, orderno: params[:id])
    render json: {status: order[:isSuccessful]}.to_json
  end

  def check_status
  end

  def cancel
  end

  def notice_success
    @order = Ims::Order.detail(request, {orderno: params["id"]})["data"]
    @title = "购买成功"
  end

  def update_promotion
    @order = Ims::Order.update_promotion(request, {
      orderno: params[:id],
      promotiondesc: params[:promotiondesc],
      promotionrules: params[:promotionrules],
      items: params[:items]
    })
    render json: {status: order[:isSuccessful]}.to_json
  end

  protected

  def set_layout
    params[:action] == "notice_success" ? "ims/user" : "ims"
  end
end
