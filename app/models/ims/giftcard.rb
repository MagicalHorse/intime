# encoding: utf-8
class Ims::Giftcard < Ims::Base

  def self.all(req, params = {})
    post(req, params.merge(path: "ims/assistant/gift_cards"))
  end

  def self.my(req, params = {})
    post(req, params.merge(path: 'giftcard/my'))
  end

  def self.send(req, params = {})
    post(req, params.merge(path: 'giftcard/send'))
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

  def self.recharge(req, params = {})
    post(req, params.merge(path: 'giftcard/recharge'))
  end

  def self.purchase(req, params = {})
    post(req, params.merge(path: 'giftcard/purchase'))
  end

  def self.changepwd(req, params = {})
    post(req, params.merge(path: 'giftcard/changepwd'))
  end

  def self.resetpwd(req, params = {})
    post(req, params.merge(path: 'giftcard/resetpwd'))
  end

  def self.refuse(req, params = {})
    post(req, params.merge(path: 'giftcard/refuse'))
  end

  def self.list(req, params = {})
    post(req, params.merge(path: 'giftcard/list'))
  end

end