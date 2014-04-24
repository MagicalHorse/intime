# encoding: utf-8
module API
  class LoginRequest < API::Base

    def self.post(req, params = {})
      super(req, params.merge(path: 'customer/outsitelogin'))
    end
  end
end
