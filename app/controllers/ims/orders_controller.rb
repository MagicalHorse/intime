class Ims::OrdersController < Ims::BaseController
  def index
    @orders = Ims::Order.my(request)["data"]["items"]
  end

  def new
    if params[:product_id].present?
      @product = API::Order.new(request, productid: params[:product_id])[:data]
      @salecolors = @product[:salecolors]
      @sizes = @salecolors.first[:sizes]
      @products = [@product]
      @order = API::Order::computeamount(request, productid: params["product_id"], quantity: 1)[:data]
    elsif params[:combo_id].present?
      @products = Ims::Order.new(request, id: params[:combo_id])[:data][:items]
      @order = Ims::Order::computeamount(request, combo_id: params["combo_id"], quantity: 1)[:data]
    end

    @timeStamp_val = Time.now.to_i
    @nonceStr_val = ("a".."z").to_a.sample(9).join('')
    sign = {
      appid: Settings.wx.appid,
      url: "http://open.weixin.qq.com/",
      timestamp: @timeStamp_val,
      noncestr: @nonceStr_val,
      accesstoken: Ims::Weixin.access_token
    }.to_param
    @addrSign_val = Digest::SHA1.hexdigest(sign)
  end

  def show
    @order = Ims::Order.detail(request, {orderno: params["id"]})["data"]
    @current_rmas = @order[:rmas].find{|rmas| rmas[:canvoid]}
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
    order = API::Order.destroy(request, orderno: params[:id])
    render json: {status: order[:isSuccessful]}.to_json
  end

  def cancel
  end
end