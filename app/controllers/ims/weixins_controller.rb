# encoding: utf-8

class Ims::WeixinsController < Ims::BaseController

  before_filter :wx_auth!, only: :login_success
  before_filter :setup_uid, only: [:auth, :login_success]


  def auth
    @title = "微信登录"
    $memcached.set("login_state_#{session[:uid]}", '已扫描', 3600)
  end

  def login
    @title = "微信登录"
    @uid = UUID.generate
    @url = Rails.application.routes.url_helpers.auth_ims_weixins_url(host: request.host, port: request.port, uid: @uid, group_id: session[:group_id])
  end

  def qrcode
    respond_to do |format|
      format.png  {render qrcode: params[:url]}
    end
  end

  def login_success
    @title = "登录成功"
    $memcached.set("login_state_#{session[:uid]}", '已登录', 3600)
    $memcached.set("login_access_token_#{session[:uid]}", session[:user_token], 3600)
  end

  def get_access_token
    login_state = $memcached.get("login_state_#{params[:uid]}") rescue nil
    access_token = $memcached.get("login_access_token_#{params[:uid]}") rescue nil
    if login_state == "已登录"
      cookies[:user_token] = { value: access_token, expires: Time.now.utc + 24.hours - 1.minutes }
    end
    render json: {status: true, login_state: login_state}
  end

  protected

  def setup_uid
    session[:uid] = params[:uid] if params[:uid].present?
  end


end