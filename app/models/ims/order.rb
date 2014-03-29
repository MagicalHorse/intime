class Ims::Order < Ims::Base

 class << self
   def my(req, params={})
     post(req, params.merge(path: 'ims/order/my'))
   end
 end

end