class Ims::User
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