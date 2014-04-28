# encoding: utf-8
module API
  class Storepromotion < API::Base
    
    class << self
      def amount(req, params = {})
        post(req, params.merge(path: 'storepromotion/amount'))
      end

      def exchange(req, params = {})
        post(req, params.merge(path: 'storepromotioncoupon/exchange'))
      end
    end
  end
end
