class Ims::Order < Ims::Base

 class << self
   def my(req, params = {})
     post(req, params.merge(path: 'ims/order/my'))
   end

   def detail(req, params = {})
     post(req, params.merge(path: 'order/detail'))
   end
 end

end