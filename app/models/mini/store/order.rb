class Mini::Store::Order < Mini::Base

 class << self
   def list(req, params = {})
     post(req, params.merge(path: 'assistant/orders'))
   end
 end

end