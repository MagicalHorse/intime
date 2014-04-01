class Ims::Income < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'ims/assistant/income_received'))
   end

   def frozen(req, params={})
     post(req, params.merge(path: 'ims/assistant/income_frozen'))
   end

   def my(req, params={})
   	post(req, params.merge(path: 'ims/assistant/income'))
   end
 end

end