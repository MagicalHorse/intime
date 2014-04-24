# encoding: utf-8
module API
  class Promotion < API::Base

    class << self

      def favor(req, params = {})
        post(req, params.merge(path: 'promotion/favor'))
      end

      def unfavor(req, params = {})
        post(req, params.merge(path: 'promotion/favor/destroy'))
      end

      def download_coupon(req, params = {})
        post(req, params.merge(path: 'promotion/coupon/create', ispass: 0))
      end

      def availoperation(req, params = {})
        post(req, params.merge(path: 'promotion/availoperations'))
      end

    end
  end
end
