require 'cacheable'
class Ims::Weixin
  extend Cacheable
  def self.access_token
    cache_get('wx_access_token', 2.hours - 100.second) {
      resp = RestClient.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Settings.wx.appid}&secret=#{Settings.wx.appsecret}")
      ActiveSupport::JSON.decode(resp)['access_token']
    }
  end
end