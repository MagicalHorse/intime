module Ims
  class Base < ActiveResource::Base
    self.format   = :json
    self.timeout  = 20
  end
end
