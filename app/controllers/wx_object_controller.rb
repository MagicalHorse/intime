require 'digest/sha1'
require 'net/http'
require 'openssl'
#require 'Base64'
require 'json'
class WxObjectController < ApplicationController
  #wrap_parameters :format=>:xml
  WX_TOKEN = "xhyt"
  CARD_SERVICE_KEY ='intimeit'
  CARD_INFO_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryinfo"
  CARD_POINT_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryscore"
  
  def validate
    signature = params[:signature]
    encrypEcho = Digest::SHA1.hexdigest([WX_TOKEN,params[:timestamp],params[:nonce]].sort.join)
    logger.info "input:#{signature}, output:#{encrypEcho}"
    sign_result= params[:echostr] if signature==encrypEcho
    render :text=>sign_result
  end

  def search2
    mockup = {:ToUserName=>params[:xml][:FromUserName],
           :FromUserName=>params[:xml][:ToUserName],
           :CreateTime=>Time.now,
           :MsgType=>'text',
           :Content=>t(:welcome),
           :FuncFlag=>1}
    render :xml=>mockup.to_xml(:skip_instruct=>true,:root=>'xml')
  end
  
  def search
    in_msg_type = params[:xml][:MsgType]
    if in_msg_type == 'text'
      in_msg_content = params[:xml][:Content].split(' ')    
      card_no = in_msg_content[0] if in_msg_content.length >0 

      if /^\d+$/ =~ card_no
        card_pwd = in_msg_content[1]
        card_info = JSON.parse(get_card_info(card_no,card_pwd))
        card_score = JSON.parse(get_card_score(card_no)) if card_info["Ret"]==1
        logger.info card_score
        return render :xml=>build_response_message {|msg|
            msg[:MsgType] ='text'
            
            msg[:Content] = t(:successmsgtemplate).sub('[level]',card_info["Lvl"]).sub('[point]',card_score['Point'].to_i.to_s)
          } if card_score && card_score["Success"]==true
        return render :xml=> build_response_message {|msg|
            msg[:MsgType] = 'text'
            msg[:Content] = t :wrongpwd
        } if card_info && card_info["Ret"] !=1
       elsif in_msg_content[0]=='Hello2BizUser'
         logger.info in_msg_content
         return render :xml=>build_response_message {|msg|
           msg[:Content] = t :commonhelp
           }
         
       end
    end
    render :xml=> build_response_message {|msg|
          msg[:MsgType] = 'text'
          msg[:Content] =t :commonhelp
          }
  end
  private
  def build_response_message
    base_msg = {:ToUserName=>params[:xml][:FromUserName],
           :FromUserName=>params[:xml][:ToUserName],
           :CreateTime=>Time.now,
           :MsgType=>'text',
           :Content=>t(:welcome),
           :FuncFlag=>1}
     yield base_msg if block_given?
     base_msg.to_xml(:skip_instruct=>true,:root=>'xml')
  end
  def get_card_score(number)
    encryp_card_no = encryp_card_no number
    request_body = {:cardno=>encryp_card_no}.to_xml(:skip_instruct=>true,:root=>'vipCard')
    post_card_service URI(CARD_POINT_URL),request_body
  end
  def get_card_info(number, pwd)
    encry_card_no =encryp_card_no(number)
    encry_pwd = Digest::MD5.hexdigest(pwd).upcase
    request_body = {:cardno=>encry_card_no,
      :passwd=>encry_pwd}.to_xml(:skip_instruct=>true,:root=>'vipCard')
    post_card_service URI(CARD_INFO_URL),request_body
  end
  def encryp_card_no(number)
    cipher = OpenSSL::Cipher.new('des-ecb')
    cipher.encrypt
    cipher.key = CARD_SERVICE_KEY
    encry_card_no =[cipher.update(number)+cipher.final].pack('m')
  end
  def post_card_service(uri, body)
    req = Net::HTTP::Post.new(uri.path)
    req.body = body
    req.content_type='application/xml'
    res = Net::HTTP.start(uri.hostname,uri.port) do |http|
      http.request(req)
    end
    case res 
      when Net::HTTPSuccess,Net::HTTPRedirection then
        res.body
      else
        raise "get card info error:#{res.message.to_s}"  
    end
  end
end
