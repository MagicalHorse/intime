# encoding: utf-8
class Ims::Base < ActiveResource::Base
	 self.site     = Settings.api.apis
  self.format   = :json
  self.timeout  = 20
end
