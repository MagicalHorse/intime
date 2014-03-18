class Ims::BaseController < ApplicationController
  before_filter :wx_auth!
  
  rescue_from Ims::Unauthorized do
    redirect_to(URI::HTTPS.build([nil, "open.weixin.qq.com", nil, "/connect/oauth2/authorize", {appid: $weixin_appid, redirect_uri: URI.escape("http://#{request.host}/weixin/auth"), response_type: 'code', scope: 'snsapi_base', state: "STATE"}.to_param, 'wechat_redirect']).to_s)
    cookies[:back_url] = request.url
  end
  
  def wx_auth!
    raise Ims::Unauthorized unless session[:wx_openid]
  end
end