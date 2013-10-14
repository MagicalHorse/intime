class Front::UsersCenterController < Front::BaseController 

  before_filter :check_current_user, :only => [:my_favorite, :my_share, :my_promotion]

  protected

  def check_current_user
    if  current_user.blank?
      redirect_to login_path
    end
  end

end
