require 'digest/sha1'
require 'net/http'
require 'openssl'
require 'json'
class Card < ActiveRecord::Base
  attr_accessible :level, :no, :point, :utoken, :validatedate, :isbinded
  CARD_SERVICE_KEY ='intimeit'
  CARD_INFO_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryinfo"
  CARD_POINT_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryscore"
  class<<self
    def get_card_score(number)
      encryp_card_no = encryp_card_no number
      request_body = {:cardno=>encryp_card_no}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_point_json = post_card_service URI(CARD_POINT_URL),request_body
      JSON.parse(card_point_json)
    end
    def get_card_info(number, pwd)
      encry_cardno =encryp_card_no(number)
      encry_pwd = Digest::MD5.hexdigest(pwd).upcase
      request_body = {:cardno=>encry_cardno,
        :passwd=>encry_pwd}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_info_json = post_card_service URI(CARD_INFO_URL),request_body
      card_info_hash = JSON.parse(card_info_json)
      logger.info card_info_hash
      return nil if !card_info_hash || card_info_hash["Ret"]!=1
      request_score_body = {:cardno=>encry_cardno}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_score_json = post_card_service URI(CARD_POINT_URL), request_score_body
      card_score_hash = JSON.parse(card_score_json)
      return nil if !card_score_hash || card_score_hash["Success"]!=true
      return Card.new(:no=>encry_cardno,
        :point=>card_score_hash["Point"].to_i,
        :validatedate=>Time.now+60*60*6,
        :level=>card_info_hash["Lvl"],
        :isbinded=>false)
       
    end
    def find_by_nopwd(token,no,pwd)
       local_card = where(:no=>encryp_card_no(no)).first

      if local_card.nil? ||local_card.validatedate<Time.now
        
        local_card = get_card_info(no,pwd) 
        return nil if local_card.nil?
        local_card[:utoken] = token
        local_card.save
      end
      local_card
    end

   private
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
end

