class Ims::Store < Api::Base
   
 class << self  
   def create(req, params={})
   	 post(req, params.merge(path: 'ims/store/create'))
   end

   def show(req, params = {})
   	 post(req, params.merge(path: 'ims/store/detail'))
   end

   def my(req, params = {})
   	 post(req, params.merge(path: 'ims/store/my'))
   end
 end  

end