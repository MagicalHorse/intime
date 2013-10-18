module API
  class Rma < API::Base

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'rma/list'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'order/rma'))
      end

      def show(req, params = {})
        post(req, params.merge(path: 'rma/detail'))
      end

      def order_index(req, params = {})
        post(req, params.merge(path: 'rma/orderlist'))
      end
    end
  end
end
