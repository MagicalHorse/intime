# encoding: utf-8
class Ims::User < Ims::Base
 ATTRIBUTES = [:id, :email, :level, :nickname, :mobile, :isbindcard, :logo, :level, :operate_right, :token,
  :card_no, :verified_phone, :identify_phone, :sms_code, :back_url, :will_charge_no, :identity_no, :charge_type,
  :other_phone, :verified_other_phones, :amount, :store_id, :max_comboitems, :group_id, :associate_id]
  attr_accessor *ATTRIBUTES

  # card_no         当前用户储值卡号
  # verified_phone  已经验证的手机号（已绑定用户拥有）
  # identify_phone  准备验证的手机号
  # other_phone     指定要验证的手机号
  # sms_code        收到的短信编码
  # back_url        验证前原本要去的链接
  # will_charge_no  准备充值的充值卡
  # charge_type     充值类型（纯充值、获赠充值）
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

  def self.latest_address(req, params = {})
    post(req, params.merge(path: "user/latest_address"))
  end

  def shopping_guide?
    level == 4
  end

  def shopping_guide_operate?
    (operate_right & 4) == 4
  end


  protected

  def assign_attributes(attributes = {})
    attributes.symbolize_keys.slice(*ATTRIBUTES).each do |k, v|
      send("#{k.to_s}=", v)
    end
  end
end
