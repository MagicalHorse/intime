module Apis
  class Base < ActiveResource::Base
    self.site     = Settings.api.apis
    self.format   = :json
    self.timeout  = 10
  end
end
