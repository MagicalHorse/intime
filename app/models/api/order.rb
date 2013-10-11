require "#{File.dirname(__FILE__)}/restful.rb"

module API::Order
  extend API::Restful

  class << self
    def index(req, params = {})
      post(req, params.merge(path: 'order/my'))
    end

    def create(req, params = {})
      post(req, params.merge(path: 'product/order'))
    end

    def show(req, params = {})
      post(req, params.merge(path: 'order/detail'))
    end

    def destory(req, params = {})
      post(req, params.merge(path: 'order/void'))
    end

    def update(req, params = {})
      post(req, params.merge(path: 'order/rma'))
    end

    def new(req, params = {})
      post(req, params.merge(path: 'product/detail4p'))
    end
  end
end
