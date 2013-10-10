class Front::BaseController < ApplicationController
  layout 'front'
  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= session[:current_user]
  end

  def signed_in?
    !!current_user
  end

  def authenticate!
    render json: { isSuccessful: false, message: 'no login', statusCode: 500 } unless signed_in?
  end

  def update_user
    result = API::Customer.show(request)
    result[:data] ||= {}
    result[:data][:access_token]  = current_user.access_token
    result[:data][:refresh_token] = current_user.refresh_token
    set_current_user(result[:data])
  end

  protected

  def set_current_user(value)
    /^__(?<provider>[0-3])(?<uid>.*)$/ =~ value['name']
    @current_user = CurrentUser.new(
      :email              => value['email'],
      :level              => value['level'],
      :nickie             => value['nickname'],
      :uid                => uid,
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

    session[:current_user] = @current_user
    session[:user_token]   = value[:token]
  end

  def set_anonymous_user
    @current_user = nil
    session[:current_user] = nil
    session[:user_token]   = nil
  end
end
