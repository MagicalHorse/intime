# encoding: utf-8
class Ims::Giftcard < Ims::Base

  # 子礼品卡Id
  SN_ID = 'gawagew'

  # 普通用户-已绑定卡的礼品卡概述
  def self.my(req, params = {})
    post(req, params.merge(path: 'giftcard/my'))
  end

  # 普通用户通过手机号得到卡信息，同时进行绑定
  def self.bind(req, params = {})
    post(req, params.merge(path: 'giftcard/bind'))
  end

  # 判断手机号是否已经绑定
  def self.isbind(req, params = {})
    post(req, params.merge(path: 'giftcard/isbind'))
  end

  def self.create(req, params = {})
    post(req, params.merge(path: 'giftcard/create'))
  end

  # 普通用户购买充值卡，列表
  def self.items(req, params = {})
    post(req, params.merge(path: 'giftcard/items'))
  end

  # 普通用户购买充值卡
  def self.transfer_detail(req, params = {})
    post(req, params.merge(path: 'giftcard/transfer_detail'))
    # TODO 上线前，删除下列测试代码
    {"data"=>{phone: 18801122329, sender: "王鑫龙", comment: "喜欢吗，送给你", amount: 500, status: 0}, "isSuccessful"=>true, "statusCode"=>200, "message"=>"ok"}
  end

  def self.latest_giftcard(req, params = {})
    post(req, params.merge(path: 'giftcard/latest_giftcard'))
    {"isSuccessful"=>true, "statusCode"=>200, "message"=>"ok", "data"=>{amount: 650, charge_no: "xxddyy", create_date: Time.now.to_s}}
  end

  def self.recharge(req, params = {})
    post(req, params.merge(path: 'giftcard/recharge'))
  end

  def self.send(req, params = {})
    post(req, params.merge(path: 'giftcard/send'))
  end

  def self.changepwd(req, params = {})
    post(req, params.merge(path: 'giftcard/change_pwd'))
  end

  def self.resetpwd(req, params = {})
    post(req, params.merge(path: 'giftcard/reset_pwd'))
  end

  def self.refuse(req, params = {})
    post(req, params.merge(path: 'giftcard/refuse'))
  end

  def self.list(req, params = {})
    post(req, params.merge(path: 'giftcard/list'))
  end

end