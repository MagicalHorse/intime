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

   def banks(req, params = {})
   	 post(req, params.merge(path: 'ims/associate/avail_banks'))
   end

   def apply(req, params = {})
   	 post(req, params.merge(path: 'ims/assistant/income_request'))
   end
 end

end