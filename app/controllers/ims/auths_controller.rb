class Ims::AuthsController < ActionController::Base
  def show
    if params[:code]
      response = Typhoeus::Request.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{$weixin_appid}&secret=#{$weixin_appsecret}&code=#{params[:code]}&grant_type=authorization_code").body
      Rails.logger.info("="*20+"get ACCESS_TOKEN")
      Rails.logger.info(response)
      session[:wx_openid] = response['openid']
      redirect_to session[:back_url]
      session.destroy(:back_url)
    else
      render text: '需要授权'
    end
  end
end