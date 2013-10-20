module API
  class Voucher < API::Base
    
    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'storepromotioncoupon/list'))
      end
    end
  end
end
