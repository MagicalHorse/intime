# encoding: utf-8
class Ims::Store::Order < Ims::Base

 class << self
   def list(req, params = {})
     post(req, params.merge(path: 'assistant/orders'))
   end
 end

end
