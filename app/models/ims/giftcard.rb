class Ims::Giftcard < Ims::Base

  def self.my(req, params = {})
    post(req, params.merge(path: 'giftcard/my'))
  end

  def self.create(req, params = {})
    post(req, params.merge(path: 'giftcard/create'))
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

  def self.list(req, params = {})
    post(req, params.merge(path: 'giftcard/list'))
  end

end