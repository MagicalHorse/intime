class Front::BaseController < ApplicationController
  layout 'application'
  helper_method :current_user, :is_login?

  def current_user
    @current_user ||= session[:current_user]
  end

  def is_login?
    !!current_user
  end

  protected

  def set_current_user(value)
    /^__(?<provider>[0-3])(?<uid>.*)$/ =~ value['name']
    @current_user = CurrentUser.new(
      :email        => value['email'],
      :level        => value['level'],
      :nickie       => value['nickname'],
      :uid          => uid,
      :provider     => provider.present? ? provider.to_i : nil,
      :isbindcard   => value['isbindcard'],
      :mobile       => value['mobile'],
      :avatar_url   => value['logo'],
      :coupon_count => value['coupontotal'],
      :point        => value['pointtotal'],
      :like_count   => value['liketotal'],
      :fans_count   => value['likedtotal'],
      :favor_count  => value['favortotal'],
      :access_token => value['access_token'],
      :expires_at   => value['expires_at']
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
