class Front::SessionsController < Front::BaseController
  def create
    self.current_user =request.env['omniauth.auth']
  end
end
