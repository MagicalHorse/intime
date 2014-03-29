class Ims::OrdersController < Ims::BaseController
  def index
    @orders = Ims::Order.my(request)["data"]["items"]
  end

  def new
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