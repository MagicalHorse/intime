module API
  class Customer < API::Base

    class << self
      def show(req, params = {})
        post(req, params.merge(path: 'customer/detail'))
      end

      def his_show(req, params = {})
        post(req, params.merge(path: 'customer/daren'))
      end
    end
  end
end
