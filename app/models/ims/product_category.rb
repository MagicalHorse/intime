class Ims::ProductCategory < Ims::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'ims/assistant/category_sizes'))
   end
 end

end