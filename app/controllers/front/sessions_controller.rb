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
    login_type =0
    if auth_data.provider=='weibo'
      login_type=1
    elsif auth_data.provider=='qq_connect'
      login_type=3
    end
    API::LoginRequest.post(request,{:outsiteuid=>auth_data.uid,:outsitenickname=>auth_data.info.nickname,:outsitetype=>login_type})
  end
end
