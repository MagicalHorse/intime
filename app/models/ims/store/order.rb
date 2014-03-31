class Ims::Store::Order < Ims::Base

 class << self
   def list(req, params = {})
     post(req, params.merge(path: 'ims/assistant/orders'))
   end
 end

end