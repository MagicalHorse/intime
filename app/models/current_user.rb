class CurrentUser
  ATTRIBUTES = [:email, :level, :nickie, :id, :provider, :isbindcard, :mobile, :avatar_url, :coupon_count, :point, :like_count, :fans_count, :favor_count, :access_token, :refresh_token, :onlinecoupontotal, :offlinecoupontotal]
  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def update(attributes = {})
    assign_attributes(attributes)
  end

  protected

  def assign_attributes(attributes = {})
    attributes.symbolize_keys.slice(*ATTRIBUTES).each do |k, v|
      send("#{k.to_s}=", v)
    end
  end
end
