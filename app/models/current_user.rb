# encoding: utf-8
class CurrentUser
  # email 用户邮箱
  # level 用户的等级 2-达人
  # nickie 用户昵称
  # id 用户的主键
  # provider 三方登录标识
  # isbindcard 是否绑定了银泰卡
  # mobile 用户电话
  # avatar_url 用户的头像url
  # coupon_count 用户总优惠码数
  # point 用户积点数
  # like_count 用户喜欢别人的数量
  # fans_count 用户fans数量
  # favor_count 用户收藏数量
  # access_token 三方登录的token
  # refresh_token
  # onlinecoupontotal 用户总线上优惠券数
  # offlinecoupontotal 用户总兑换券数
  ATTRIBUTES = [:email, :level, :nickie, :id, :provider, :isbindcard, :mobile, :avatar_url, :coupon_count, :point, :like_count, :fans_count, :favor_count, :access_token, :refresh_token, :onlinecoupontotal, :offlinecoupontotal]
  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def attributes
    ATTRIBUTES.inject({}) do |result, attr|
      result[attr] = send(attr); result
    end
  end

  def avatar_url
    if defined?(@avatar_url)
      @avatar_url = @avatar_url.present? ? @avatar_url : Settings.default_image_url.user
    end
  end

  protected

  def assign_attributes(attributes = {})
    attributes.symbolize_keys.slice(*ATTRIBUTES).each do |k, v|
      send("#{k.to_s}=", v)
    end
  end
end
