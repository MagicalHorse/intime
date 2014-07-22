# encoding: utf-8
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

    # 计算 运费 总积分 总金额 商品价格
    def computeamount(req, params = {})
      post(req, params.merge(path: 'combo/computeamount'))
    end

    def update_promotion(req, params = {})
      post(req, params.merge(path: 'order/fill_pro', content_type: :json))
    end

  end

end
