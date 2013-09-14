class Front::SessionsController < Front::BaseController

  def create
    login_user = login_from_api
    if login_user[:isSuccessful]==true
      set_current_user(login_user[:data])
    else
      logger.info(login_user)
      set_anonymous_user
    end
  end

  private

  def login_from_api
    auth_data = request.env['omniauth.auth']
    login_type = case auth_data.provider
                 when 'weibo'      then Settings.provider.weibo
                 when 'tqq'        then Settings.provider.tqq
                 when 'qq_connect' then Settings.provider.qq_connect
                 else Settings.provider.other
                 end

    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => auth_data.uid,
      :outsitenickname  => auth_data.info.nickname,
      :outsitetype      => login_type
    })

    user_hash[:data] ||= {}
    user_hash[:data][:access_token] = auth_data.credentials.token
    # 腾讯微博的 access_token 有效期为 3 个月  http://wiki.open.t.qq.com/index.php/OAuth2.0%E9%89%B4%E6%9D%83
    user_hash[:data][:expires_at]   = login_type == Settings.provider.tqq ? 3.months.since.to_i : auth_data.credentials.expires_at
    user_hash
  end
end
