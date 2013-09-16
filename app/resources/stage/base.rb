module Stage
  class Base < ActiveResource::Base
    self.site     = Settings.api.stage
    self.format   = :json
    self.timeout  = 20
  end
end
