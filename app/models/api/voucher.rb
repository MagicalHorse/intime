# encoding: utf-8
module API
  class Voucher < API::Base

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'storepromotioncoupon/list'))
      end

      def show(req, params = {})
        post(req, params.merge(path: 'storepromotioncoupon/detail'))
      end

      def void(req, params = {})
        post(req, params.merge(path: 'storepromotioncoupon/void'))
      end
    end
  end
end
