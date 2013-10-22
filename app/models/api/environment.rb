module API
  class Environment < API::Base

    class << self
      # 省市区
      def supportshipments(req, params = {})
        post(req, params.merge(path: 'environment/supportshipments'))
      end

      # 退货理由分类列表
      def supportrmareasons(req, params = {})
        post(req, params.merge(path: 'environment/supportrmareasons'))
      end

      # 运输公司列表
      def supportshipvias(req, params = {})
        post(req, params.merge(path: 'environment/supportshipvias'))
      end
    end
  end
end
