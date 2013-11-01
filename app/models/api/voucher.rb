module API
  class Voucher < API::Base

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'storepromotioncoupon/list'))
      end

      def show(req, params = {})
        post(req, params.merge(path: 'storepromotion/detail'))
      end
    end
  end
end
