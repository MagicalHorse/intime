class Ims::Order < Ims::Base

 class << self

  def new(req, params = {})
    post(req, params.merge(path: 'combo/detail4p'))
  end

  def my(req, params = {})
    post(req, params.merge(path: 'order/my'))
  end

  def detail(req, params = {})
    post(req, params.merge(path: 'order/detail', api_path: true))
  end
 end

end