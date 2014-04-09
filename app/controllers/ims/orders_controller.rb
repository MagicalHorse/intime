class Ims::OrdersController < Ims::BaseController
  def index
    @orders = Ims::Order.my(request)["data"]["items"]
  end

  def new
    @product = API::Order.new(request, productid: params["product_id"])[:data]
    @salecolors = @product[:salecolors]
    @sizes = @salecolors.first[:sizes]
    @products = params[:product_id].present? ? [@product] : [@product]
    @order = API::Order::computeamount(request, productid: params["product_id"], quantity: 1)[:data]
    @timeStamp_val = Time.now.to_i
    @nonceStr_val = ("a".."z").to_a.sample(9).join('')
    sign = {
      appid: Settings.wx.appid,
      url: "http://open.weixin.qq.com/",
      timeStamp: @timeStamp_val,
      nonceStr: @nonceStr_val,
      accessToken: Ims::Weixin.access_token
    }.to_param.downcase
    @addrSign_val = Digest::SHA1.hexdigest(sign)
  end

  def show
    # @order = Ims::Order.detail(request, {orderno: params["id"]})["data"]["items"]
    @order = {"products" => []}
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
  end

  def change_state
    render json: {status: true, id: 1}.to_json
  end

  def cancel
  end
end