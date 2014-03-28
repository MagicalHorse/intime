class Ims::Product < Ims::Base


  class << self
    def list(req, params={})
      post(req, params.merge(path: 'ims/assistant/products'))
    end

    def create(req, params={})
      post(req, params.merge(path: 'ims/product/create'))
    end

    def show(req, params = {})
      post(req, params.merge(path: 'ims/combo/detail'))
    end

    def search(req, params = {})
      post(req, params.merge(path: 'ims/product/search'))
    end

    def salescodes(req, params = {})
      post(req, params.merge(path: 'ims/assistant/salescodes'))
    end

    def user_brands(req, params = {})
      post(req, params.merge(path: 'ims/assistant/brands'))
    end
  end

  Price = [
    {name: "100元以内", to: 100, type: 1},
    {name: "100元~200元", from: 100, to: 200, type: 1},
    {name: "200元~300元", from: 200, to: 300, type: 1},
    {name: "300元~400元", from: 300, to: 400, type: 1},
    {name: "400元~500元", from: 400, to: 500, type: 1},
    {name: "500元以上", from: 500, type: 1}
  ]

  Discount = [
    {name: "10%以下", to: 10, type: 2},
    {name: "10%~20%", from: 10, to: 20, type: 2},
    {name: "20%~30%", from: 20, to: 30, type: 2},
    {name: "30%~40%", from: 30, to: 40, type: 2},
    {name: "40%~50%", from: 40, to: 50, type: 2},
    {name: "50%以上", from: 50, type: 2}
  ]

end