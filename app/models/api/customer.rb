module API
  module Customer
    extend API::Restful

    class << self
      def show(req, params = {})
        post(req, params.merge(path: 'customer/detail'))
      end
    end
  end
end
