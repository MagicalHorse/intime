# encoding: utf-8
class Front::SessionsController < Front::BaseController
  def create
    login_user = login_from_api
    if login_user[:isSuccessful]==true
      set_current_user(login_user[:data])
    else
      logger.info(login_user)
      set_anonymous_user
    end
    return_url = session[:return_to]
    return_url = root_url if return_url.nil?
    redirect_to(return_url) and return
  end

  def login
    session[:return_to] = params[:return_to]
    if signed_in?
      redirect_to(root_url) and return
    end
  end

  def destory
    reset_session
    redirect_to root_path
  end

  private

  def login_from_api
    auth_data = request.env['omniauth.auth']

    login_type = case auth_data.provider
                 when 'weibo'      then Settings.provider.weibo
                 when 'tqq2'       then Settings.provider.tqq
                 when 'qq_connect' then Settings.provider.qq_connect
                 when 'wechat'      then Settings.provider.wechat
                 else Settings.provider.other
                 end

    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => auth_data.uid,
      :outsitenickname  => auth_data.info.nickname,
      :outsitetype      => login_type,
      :outsitetoken     => auth_data.credentials.token
    })

    user_hash[:data] ||= {}
    user_hash[:data][:access_token]  = auth_data.credentials.token
    user_hash[:data][:refresh_token] = auth_data.credentials.refresh_token
    user_hash
  end
end
