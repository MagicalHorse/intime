class Ims::Combo < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'assistant/combos'))
   end

   def create(req, params={})
   	 post(req, params.merge(path: 'combo/create', content_type: :json))
   end

   def show(req, params = {})
   	 post(req, params.merge(path: 'combo/detail'))
   end

   def update(req, params = {})
      post(req, params.merge(path: 'combo/update', content_type: :json))
   end   

   def upload_img(req, params ={})
   	post(req, params.merge(path: 'resource/upload'))
   end

   def online_num(req, params = {})
      post(req, params.merge(path: 'associate/combos_online_count'))
   end
 end

end