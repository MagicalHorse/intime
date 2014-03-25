require 'cacheable'
class Ims::Weixin
  extend Cacheable
  def self.access_token
    cache_get('wx_access_token', 2.hours - 100.second) {
      resp = RestClient.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Settings.wx.appid}&secret=#{Settings.wx.appsecret}")
      ActiveSupport::JSON.decode(resp)['access_token']
    }
  end

  def self.sign_value(sessionid = Time.now.to_i)
    Digest::MD5.hexdigest("#{API_KEY}client_version#{CLIENT_VERSION}uid#{sessionid}#{API_KEY}")
  end
end