module WxobjectHelper
   def build_response_nofound
      response = WxTextResponse.new
      set_common_response response
      response.Content = t :keynotfound
      response     
   end
   def set_common_response(resp)
     resp.ToUserName=params[:xml][:FromUserName]
     resp.FromUserName=params[:xml][:ToUserName]
     resp.CreateTime=Time.now
     resp.MsgType='text'
     resp.FuncFlag=1
   end
    
end
