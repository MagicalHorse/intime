class Ims::Store < Ims::Base
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

   def update(req, params = {})
      post(req, params.merge(path: 'ims/assistant/update'))
   end


   #导购收益礼品卡
   def giftcard_records(req, params = {})
   	 post(req, params.merge(path: 'ims/assistant/order_giftcards'))
   end
   
   #导购收益订单
   def order_records(req, params = {})
   	 post(req, params.merge(path: 'ims/assistant/orders'))
   end

 end

end