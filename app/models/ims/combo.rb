class Ims::Combo < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'assistant/combos'))
   end

   def create(req, params={})
   	 post(req, params.merge(path: 'combo/create'))
   end

   def show(req, params = {})
   	 post(req, params.merge(path: 'combo/detail'))
   end

   def upload_img(req, params ={})
   	 post(req, params.merge(path: 'resource/upload'))
   end
 end

end