# encoding: utf-8
class Ims::AuthsController < Ims::BaseController

  skip_before_filter :wx_auth!

  # 在微信端验证后，客户端的响应页面
  def show
    if (code = params[:code]).present?
      json_resp = get_access_token(code, session[:group_id])
      session[:wx_openid] = json_resp['openid']
      cookies[:user_access_token] = { value: json_resp["access_token"], expires: (json_resp["expires_in"] - 100).seconds.from_now.utc }
      redirect_to (session[:back_url] || params[:back_url])
      session.delete(:back_url)
    else
      render text: '需要授权'
    end
  end

  def forward
    raw_url = params[:raw_url]
    if !raw_url.present?
      render text: 'empty raw url'
    end
    redirect_to("#{raw_url}&#{request.query_string}")
  end


  private

  def get_access_token(code, group_id, flag = 0)
    flag += 1
    weixin_key = API::Environment.getweixinkey(request, groupid: group_id)[:data]
    resp = RestClient.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{weixin_key[:app_id]}&secret=#{weixin_key[:app_secret]}&code=#{code}&grant_type=authorization_code")
    json_resp = ActiveSupport::JSON.decode(resp)
    if flag <= 3 && json_resp["access_token"].blank?
      get_access_token(code, group_id, flag)
    elsif json_resp["access_token"]
      json_resp
    else
      $logger.error("获取access_token错误")
    end
  end

end
