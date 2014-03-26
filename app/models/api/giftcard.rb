class API::Giftcard < API::Base

  def self.my(req, params = {})
    post(req, params.merge(path: 'ims/giftcard/my'))
  end

  def self.create(req, params = {})
    post(req, params.merge(path: 'ims/giftcard/create'))
  end

  def self.purchase(req, params = {})
    post(req, params.merge(path: 'ims/giftcard/purchase'))
  end

  def self.changepwd(req, params = {})
    post(req, params.merge(path: 'ims/giftcard/changepwd'))
  end

  def self.resetpwd(req, params = {})
    post(req, params.merge(path: 'ims/giftcard/resetpwd'))
  end

end