class Ims::Income < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'ims/assistant/combos'))
   end

   def my(req, params={})
   	post(req, params.merge(path: 'ims/assistant/income'))
   end
 end

end