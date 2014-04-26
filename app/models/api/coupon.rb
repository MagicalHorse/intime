# encoding: utf-8
module API
  class Coupon < API::Base

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'coupon/list'))
      end
    end
  end
end
