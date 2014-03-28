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

  def self.create(req, params = {})
    post(req, params.merge(path: 'giftcard/create'))
  end

  def self.items(req, params = {})
    post(req, params.merge(path: 'giftcard/items'))
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