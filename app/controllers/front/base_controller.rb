class Front::BaseController < ApplicationController
  layout 'application'
  helper_method [:current_user,:is_login?]
  def current_user
    return @current_user||=session[:current_user]
  end
  def is_login?
    return !(current_user.nil?)
  end
  protected
  def set_current_user(value)
    @current_user =User.new({:email=>value["email"],:level=>value["level"],:nickie=>value['nickname']})
    session[:current_user]= @current_user
    session[:user_token]=value[:token]
  end
  def set_anonymous_user
    @current_user=nil
    session[:current_user]= nil
    session[:user_token]=nil
  end
end