require 'digest/sha1'
require 'net/http'

class WxObjectController < ApplicationController
  #wrap_parameters :format=>:xml
  WX_TOKEN = "xhyt"
  CARD_INFO_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryinfo"
  CARD_POINT_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryscore"
  
  def validate
    signature = params[:signature]
    encrypEcho = Digest::SHA1.hexdigest([WX_TOKEN,params[:timestamp],params[:nonce]].sort.join)
    logger.info "input:#{signature}, output:#{encrypEcho}"
    sign_result= params[:echostr] if signature==encrypEcho
    render :text=>sign_result
  end

  def search
    mockup = {:ToUserName=>params[:xml][:FromUserName],
           :FromUserName=>params[:xml][:ToUserName],
           :CreateTime=>Time.now,
           :MsgType=>'text',
           :Content=>t(:welcome),
           :FuncFlag=>1}
    render :xml=>mockup.to_xml(:skip_instruct=>true,:root=>'xml')
  end
  
  def search2
    mockup = {:ToUserName=>params[:xml][:FromUserName],
           :FromUserName=>params[:xml][:ToUserName],
           :CreateTime=>Time.now,
           :MsgType=>'text',
           :Content=>WELCOME_MSG,
           :FuncFlag=>1}
    in_msg_type = params[:xml][:MsgType]
    if in_msg_type == 'text'
      in_msg_content = params[:xml][:Content]
      in_msg_content.parse(' ').each do |content|
        content.is_number?
      end
    end
    render :xml=>mockup.to_xml(:skip_instruct=>true,:root=>'xml')
  end
end
