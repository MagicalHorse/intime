# encoding: utf-8
require 'digest/sha1'
require 'net/http'
require 'openssl'
require 'json'
require 'base64'
class Card < ActiveRecord::Base
  attr_accessible :level, :no, :point, :utoken, :validatedate, :isbinded
  CARD_SERVICE_KEY ='intimeit'
  def decryp_card_no
    Card.decryp_card_no self.no
  end
  
  class<<self
    # call remote card service to retrieve the latest card information
    # there are two services avail for card: 
    # 1. card basic info with input of number, pwd
    # 2. card point with input of number
    def get_card_info(number, pwd)
      encry_cardno =encryp_card_no(number)
      encry_pwd = Digest::MD5.hexdigest(pwd).upcase
      request_body = {:cardno=>encry_cardno,
        :passwd=>encry_pwd}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_info_json = post_card_service URI(CARD_INFO_URL),request_body
      card_info_hash = JSON.parse(card_info_json)
      return nil if !card_info_hash || card_info_hash["Ret"]!=1
      request_score_body = {:cardno=>encry_cardno}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_score_json = post_card_service URI(CARD_POINT_URL), request_score_body
      card_score_hash = JSON.parse(card_score_json)

      return nil if !card_score_hash || card_score_hash["Success"]!=true
      return Card.new(:no=>encry_cardno,
        :point=>card_score_hash["Point"].to_i,
        :validatedate=>Time.now+60*60*6,
        :level=>card_info_hash["Lvl"].sub(I18n.t(:card_level_repl),I18n.t(:card_level_repl_to)),
        :isbinded=>false)
       
    end
    def find_by_nopwd(token,no,pwd)
      encrpted_no = encryp_card_no(no)
       local_card = where(:no=>encrpted_no,:utoken=>token).first
      if local_card.nil? ||local_card.validatedate<Time.now      
        remote_card = get_card_info(no,pwd) 
        return nil if remote_card.nil?
        local_card = Card.new if local_card.nil?
        local_card.point = remote_card.point
        local_card.validatedate = remote_card.validatedate
        local_card.level = remote_card.level
        local_card.no = encrpted_no
        local_card.isbinded = remote_card.isbinded if local_card.nil?
        local_card[:utoken] = token
        local_card.save
      else
        local_card.updated_at = Time.now
        local_card.save
      end
      local_card
    end
    def renew_card(token)
      local_card = where(:utoken=>token,:isbinded=>true).first
      return nil if local_card.nil?
      remote_card_hash = get_card_score(local_card.no)
      local_card.point = remote_card_hash['Point'].to_i
      local_card.validatedate = Time.now+60*60*6
      local_card.save
      local_card
    end
    def point_exchange(cardno,amount)
      request_body = {:cardno=>encryp_card_no(cardno),
        :score=>amount}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_exchange_json = post_card_service URI(CARD_EXCHANGE_URL),request_body
      card_exchange_hash = JSON.parse(card_exchange_json)
      return !card_exchange_hash.nil? && card_exchange_hash["Success"]==true

    end
    def decryp_card_no(number)
      cipher = OpenSSL::Cipher.new('des-ecb')
      cipher.decrypt
      cipher.key = CARD_SERVICE_KEY
      cipher.update(Base64.decode64(number))+cipher.final
    end
   private
    def get_card_score(encrp_no)
      encryp_card_no = encrp_no
      request_body = {:cardno=>encryp_card_no}.to_xml(:skip_instruct=>true,:root=>'vipCard')
      card_point_json = post_card_service URI(CARD_POINT_URL),request_body
      JSON.parse(card_point_json)
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
end

