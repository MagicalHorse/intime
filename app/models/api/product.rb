# encoding: utf-8
module API
  class Product < API::Base

    class << self

      def his_favorite(req, params = {})
        post(req, params.merge(path: 'favorite/daren'))
      end

      #sourcetype: 1喜欢, 2促销
      def my_favorite(req, params = {})
        post(req, params.merge(path: 'favorite/my'))
      end

      def my_share_list(req, params = {})
        post(req, params.merge(path: 'items/list'))
      end

      def favor(req, params = {})
        post(req, params.merge(path: 'product/favor'))
      end

      def unfavor(req, params = {})
        post(req, params.merge(path: 'product/favor/destroy'))
      end

      def download_coupon(req, params = {})
        post(req, params.merge(path: 'product/coupon', ispass: 0))
      end

      def availoperation(req, params = {})
        post(req, params.merge(path: 'product/availoperations'))
      end
    end
  end
end
