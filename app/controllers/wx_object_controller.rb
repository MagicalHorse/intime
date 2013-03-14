require 'digest/sha1'
class WxObjectController < ApplicationController
  wrap_parameters :format=>:xml
  WX_TOKEN = "xhyt"
  def validate
    signature = params[:signature]
    encrypEcho = Digest::SHA1.hexdigest([WX_TOKEN,params[:timestamp],params[:nonce]].sort.join)
    logger.info "input:#{signature}, output:#{encrypEcho}"
    sign_result= signature if signature==encrypEcho
    render :text=>sign_result
  end
  def search
    mockup = {:ToUserName=>params[:xml][:FromUserName],
           :FromUserName=>params[:xml][:ToUserName],
           :CreateTime=>Time.now,
           :MsgType=>'text',
           :Content=>'欢迎使用喜欢银泰，目前服务正在开发中，即将上线!',
           :FuncFlag=>1}
    render :xml=>mockup.to_xml(:skip_instruct=>true,:root=>'xml')
  end
end
