class Front::SessionsController < Front::BaseController
  def create
    @current_user =request.env['omniauth.auth']
    logger.info @current_user
  end
end
