module API
  class Customer < API::Base

    class << self
      def show(req, params = {})
        post(req, params.merge(path: 'customer/detail'))
      end
    end
  end
end
