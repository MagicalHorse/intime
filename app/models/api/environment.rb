# encoding: utf-8
require 'cacheable'
module API
  class Environment < API::Base
    extend Cacheable
    class << self
      # 省市区
      def supportshipments(req, params = {})
        cache_get('env_shippments',1.day) {
           post(req, params.merge(path: 'environment/supportshipments'))
        }
      end

      # 退货理由分类列表
      def supportrmareasons(req, params = {})
        cache_get('env_rmareasons',1.day) {
          post(req, params.merge(path: 'environment/supportrmareasons'))
        }
      end

      # 运输公司列表
      def supportshipvias(req, params = {})
        cache_get('env_shipvias',1.day) {
          post(req, params.merge(path: 'environment/supportshipvias'))
        }
      end

      # support invoice details
      def supportinvoicedetails(req, params = {})
        cache_get('env_invoicedetails',1.day) {
          post(req, params.merge(path: 'environment/supportinvoicedetails'))
        }
      end

      def getalipaykey(req, params = {})
        cache_get("env_getalipaykey_#{params[:group_id]}", 30.minutes) {
          post(req, params.merge(path: 'environment/getalipaykey'))
        }
      end

      def getweixinkey(req, params = {})
        cache_get("env_getweixinkey_#{params[:group_id]}", 30.minutes) {
          post(req, params.merge(path: 'environment/getweixinkey'))
        }
      end

    end
  end
end
