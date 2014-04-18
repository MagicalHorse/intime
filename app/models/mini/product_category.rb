class Mini::ProductCategory < Mini::Base

 class << self
   def list(req, params={})
     post(req, params.merge(path: 'assistant/category_sizes'))
   end
 end

end