class Ims::OrdersController < Ims::Base
  def new
    @timeStamp_val = Time.now.to_i
    @nonceStr_val = ("a".."z").to_a.simple(9)
    sign = {
      appid: Setting.wx.appid,
      url: "http://open.weixin.qq.com/",
      timeStamp: @timeStamp_val,
      nonceStr: @nonceStr_val,
      accessToken: Ims::Weixin.access_token
    }.to_param
    @addrSign_val = Digest::SHA1.hexdigest(sign)
  end
end