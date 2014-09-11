# encoding: utf-8
require 'cacheable'
class Ims::Weixin
  extend Cacheable
  def self.access_token(group_id)
    cache_get('wx_access_token', 2.hours - 100.second) {
      weixin_key = API::Environment.getweixinkey(request, groupid: group_id)[:data]
      resp = RestClient.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{weixin_key[:app_id]}&secret=#{weixin_key[:app_secret]}")
      ActiveSupport::JSON.decode(resp)['access_token']
    }
  end

  def self.renew
    client.delete 'wx_access_token'
    access_token
  end

end
