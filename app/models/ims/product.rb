class Ims::Product < Api::Base
 
 class << self  
   def list(req, parmas={})
     post(req, params.merge(path: 'ims/assistant/products'))
   end

   def create(req, params={})
   	 post(req, params.merge(path: 'ims/product/create'))
   end

   def show(req, params = {})
   	 post(req, params.merge(path: 'ims/combo/detail'))
   end

   def search(req, params = {})
   	 post(req, params.merge(path: 'ims/product/search'))
   end

   def salescodes(req, params = {})
   	 post(req, params.merge(path: 'ims/assistant/salescodes'))
   end

   def user_brands(req, params = {})
   	 post(req, params.merge(path: 'ims/assistant/brands'))
   end

   
 end  

end