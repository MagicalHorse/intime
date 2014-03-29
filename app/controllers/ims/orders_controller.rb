class Ims::OrdersController < Ims::BaseController
  def index
    @orders = Ims::Order.my(request)["data"]["items"]
  end

  def new
    @product = Ims::Product.find(request, id: params["id"])
    @product = {id: 1, image: "/images/1.jpg", price: 100.1, brand_id: 2, brand_name: "mockup品牌1",
      sales_code: "mockupsalescode1", sku_code: "sku_code", category_id: 1,
      category_name: "mockup分类1", size_str: '1111', size: [{size_id: 1, size_name: "mockup尺码1"}, {size_id: 2, size_name: "mockup尺码2"}]}
    @sizes = Ims::ProductSize.list(request, category_id: @product[:category_id])
    @timeStamp_val = Time.now.to_i
    @nonceStr_val = ("a".."z").to_a.sample(9).join('')
    sign = {
      appid: Settings.wx.appid,
      url: "http://open.weixin.qq.com/",
      timeStamp: @timeStamp_val,
      nonceStr: @nonceStr_val,
      accessToken: Ims::Weixin.access_token
    }.to_param
    @addrSign_val = Digest::SHA1.hexdigest(sign)
  end

  def show
    # @order = Ims::Order.detail(request, {orderno: params["id"]})["data"]["items"]
    @order = {"products" => []}
  end

  def create
    render json: {status: true, id: 1}.to_json
  end

  def payments
  end

  def change_state
    render json: {status: true, id: 1}.to_json
  end

  def cancel
  end
end