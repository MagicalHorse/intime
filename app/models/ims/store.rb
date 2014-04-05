class Ims::Store < Ims::Base
 class << self  
   def create(req, params={})
   	 post(req, params.merge(path: 'store/create'))
   end

   def show(req, params = {})
   	 post(req, params.merge(path: 'store/detail'))
   end

   def my(req, params = {})
   	 post(req, params.merge(path: 'store/my'))
   end

   def update(req, params = {})
      post(req, params.merge(path: 'assistant/update'))
   end


   #导购收益礼品卡
   def giftcard_records(req, params = {})
   	 post(req, params.merge(path: 'assistant/order_giftcards'))
   end
   
   #导购收益订单
   def order_records(req, params = {})
   	 post(req, params.merge(path: 'assistant/orders'))
   end

   def giftcards(req, params = {})
      post(req, params.merge(path: 'assistant/gift_cards'))
   end

   def combos(req, params = {})
      post(req, params.merge(path: 'assistant/combos'))
   end

 end

end