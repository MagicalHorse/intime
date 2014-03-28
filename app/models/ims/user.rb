class Ims::User
 ATTRIBUTES = [:id, :email, :level, :nickname, :mobile, :isbindcard, :logo, :level, :operate_right, :token, :card_no, :verified_phone, :identify_phone, :sms_code, :back_url, :will_charge_no, :identity_no]
  attr_accessor *ATTRIBUTES

  # card_no         当前用户储值卡号
  # verified_phone  已经验证的手机号
  # identify_phone  准备验证的手机号
  # sms_code        收到的短信编码
  # back_url        验证前原本要去的链接
  # will_charge_no  准备充值的充值卡
  # identity_no     身份证

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