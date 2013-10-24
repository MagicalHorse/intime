# encoding: utf-8
class Front::BaseController < ApplicationController
  layout 'front'
  helper_method :current_user, :signed_in?
  before_filter :update_current_user

  # TODO
  # 前端测试用，暂时加上
  skip_before_filter :verify_authenticity_token

  def current_user
    @current_user ||= session[:current_user]
  end

  def signed_in?
    !!current_user
  end

  def authenticate!
    return true if signed_in?
    fake_current_user and return true

    if request.xhr?
      render json: { isSuccessful: false, message: 'no login', statusCode: 500 }
    else
      redirect_to "#{login_path}?return_to=#{Rack::Utils.escape(request.original_url)}"
    end
  end

  def update_current_user
    if signed_in? && !request.xhr?
      result = API::Customer.show(request)
      result[:data] ||= {}
      result[:data][:access_token]  = current_user.access_token
      result[:data][:refresh_token] = current_user.refresh_token
      set_current_user(result[:data])
      logger.info("-----> update current_user #{current_user.attributes}")
    end
  end

  def render_datas(datas, options = nil)
    result = {
      page:       datas.current_page,
      pagesize:   datas.limit_value,
      totalcount: datas.total_count,
      totalpaged: datas.total_pages,
      datas:      datas
    }

    result.merge!(options.delete_if {|k,v| v.blank? }) if options.present?

    render json: result.to_json, callback: params[:callback]
  end

  def format_items(data, *except_keys)
    result = {
      page:       data[:pageindex],
      pagesize:   data[:pagesize],
      totalcount: data[:totalcount],
      totalpaged: data[:totalpaged],
      datas:      data[:items]
    }

    result.except(*except_keys)
  end

  def render_items(data, options = nil)
    render json: format_items(data, options), callback: params[:callback]
  end

  def fake_current_user
    session[:current_user] = CurrentUser.new({
      :email=>"",
      :level=>1,
      :nickie=>"银泰2013",
      :id=>45,
      :provider=>3,
      :isbindcard=>nil,
      :mobile=>"",
      :avatar_url=>"",
      :coupon_count=>0,
      :point=>100,
      :like_count=>0,
      :fans_count=>0,
      :favor_count=>0,
      :access_token=>"FB2166296E70FC4693379C261E27ACF2",
      :refresh_token=>"6383F262273FF94ECE79A07BE01BF86A",
      :onlinecoupontotal=>0,
      :offlinecoupontotal=>0
    })
    session[:user_token]   = 'g1vS%2BfIPu1VcU9FBgoe5btrbCIco61HTzS56b9K2P8dlVsTwUjp5pkaIKtopaMXv'

    set_login_cookie
  end

  protected

  def set_current_user(value)
    /^__(?<provider>[0-3])(?<uid>.*)$/ =~ value['name']
    @current_user = CurrentUser.new(
      :email              => value['email'],
      :level              => value['level'],
      :nickie             => value['nickname'],
      :id                 => value['id'],
      :provider           => provider.present? ? provider.to_i : nil,
      :isbindcard         => value['isbindcard'],
      :mobile             => value['mobile'],
      :avatar_url         => value['logo'],
      :coupon_count       => value['coupontotal'],
      :point              => value['pointtotal'],
      :like_count         => value['liketotal'],
      :fans_count         => value['likedtotal'],
      :favor_count        => value['favortotal'],
      :onlinecoupontotal  => value['onlinecoupontotal'],
      :offlinecoupontotal => value['offlinecoupontotal'],
      :access_token       => value['access_token'],
      :refresh_token      => value['refresh_token']
    )

    set_login_cookie

    session[:current_user] = @current_user
    session[:user_token]   = value[:token]
  end

  def set_anonymous_user
    @current_user = nil
    session[:current_user] = nil
    session[:user_token]   = nil

    clear_login_cookie
  end

  def clear_login_cookie
    cookies[:login] = nil
  end

  def set_login_cookie
    cookies[:login] = {
      value:    current_user.nickie,
      domain:   Settings.domain,
      path:     '/',
      expires:  Time.now.end_of_day
    }
  end
end
