# encoding: utf-8
class WxReplyMsg < ActiveRecord::Base
  attr_accessible :rkey, :rmsg, :status
  class<<self
    def get_msg_by_key(key)
      exist_auto_reply = WxReplyMsg.find_by_rkey_and_status(key,1) 
      return '' if exist_auto_reply.nil?
      return exist_auto_reply.rmsg     
    end
  end
end
