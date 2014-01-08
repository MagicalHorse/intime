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
    end
  end
end
