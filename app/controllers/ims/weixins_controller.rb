# encoding: utf-8

class Ims::WeixinsController < Ims::BaseController

  before_filter :wx_auth!, only: :login_success
  before_filter :setup_uid, only: [:auth, :login_success]


  def auth
    @title = "微信登录"
    $memcached.set("login_state_#{session[:uid]}", '已扫描', 3600)
    logout
  end

  def login
    @title = "微信登录"
    @uid = UUID.generate
    @url = Rails.application.routes.url_helpers.auth_ims_weixins_url(host: request.host, port: request.port, uid: @uid, group_id: session[:group_id])
    logout
  end

  def qrcode
    respond_to do |format|
      format.png  {render qrcode: params[:url]}
    end
  end

  def login_success
    @title = "登录成功"
    $memcached.set("login_state_#{session[:uid]}", '已登录', 3600)
    $memcached.set("login_access_token_#{session[:uid]}", cookies[:user_token], 3600)
    $memcached.set("login_wx_openid_#{session[:uid]}", session[:wx_openid], 3600)
  end

  def get_access_token
    login_state = $memcached.get("login_state_#{params[:uid]}") rescue nil
    access_token = $memcached.get("login_access_token_#{params[:uid]}") rescue nil
    wx_openid = $memcached.get("login_wx_openid_#{params[:uid]}") rescue nil
    hash = {status: true, login_state: login_state}
    if login_state == "已登录"
      cookies[:user_token] = { value: access_token, expires: Time.now.utc + 24.hours - 1.minutes }
      session[:wx_openid] = wx_openid
      get_token_from_api(request) if session[:current_wx_user].blank?
      hash.merge!(error_message: current_user.shopping_guide? && current_user.associate_id.blank? ? "您还没有申请开店，请通过手机微信完成开店申请流程,并且刷新当前pc页面，重新使用微信登录！" : "")
    end
    render json: hash.to_json
  end

  protected

  def setup_uid
    session[:uid] = params[:uid] if params[:uid].present?
  end


end