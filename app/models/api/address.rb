module API
  class Address < API::Base
    MAX_SIZE = 8

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'address/my'))
      end

      def update(req, params = {})
        post(req, params.merge(path: 'address/update'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'address/create'))
      end

      def destory(req, params = {})
        post(req, params.merge(path: 'address/delete'))
      end

      # 送货地址省市链接
      def supportshipments(req, params = {})
        post(req, params.merge(path: 'environment/supportshipments'))
      end
    end
  end
end
