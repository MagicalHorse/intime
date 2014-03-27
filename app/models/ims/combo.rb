class Ims::Combo < Ims::Base
   
 class << self
   def list(req, parmas={})
     post(req, params.merge(path: 'ims/assistant/combos'))
   end

   def create(req, params={})
   	 post(req, params.merge(path: 'ims/combo/create'))
   end

   def show(req, params = {})
   	 post(req, params.merge(path: 'ims/combo/detail'))
   end

   def upload_img(req, params ={})
   	 post(req, params.merge(path: 'ims/resource/upload'))
   end
 end

end