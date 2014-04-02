class Ims::Income < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'assistant/income_received'))
   end

   def frozen(req, params={})
     post(req, params.merge(path: 'assistant/income_frozen'))
   end

   def my(req, params={})
   	post(req, params.merge(path: 'assistant/income'))
   end

   def banks(req, params = {})
   	 post(req, params.merge(path: 'assistant/avail_banks'))
   end

   def apply(req, params = {})
   	 post(req, params.merge(path: 'assistant/income_request'))
   end
 end

end