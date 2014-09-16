# encoding: utf-8
require 'cacheable'
class Ims::Weixin
  extend Cacheable

  def self.access_token(weixin_key)
    cache_get("wx_access_token_#{weixin_key[:app_id]}", 2.hours - 100.second) {
      resp = RestClient.get("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{weixin_key[:app_id]}&secret=#{weixin_key[:app_secret]}")
      ActiveSupport::JSON.decode(resp)['access_token']
    }
  end

  # def self.renew
  #   client.delete 'wx_access_token'
  #   access_token
  # end

  def self.qr_ticket(weixin_key, scene_id, options={})
    options[:qr_scene] ||= "QR_SCENE"
    options[:expire_seconds] ||= '1800'
    json_body = {
      action_name: "QR_SCENE",
      action_info: {scene: {scene_id: scene_id}}
    }
    json_body=json_body.merge(options)
    resp = Typhoeus::Request.post("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=#{access_token(weixin_key)}", body: json_body.to_json).body
    JSON.parse(resp)['ticket']
  end

  def self.qr_url(weixin_key, scene_id, options={})
    "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=#{qr_ticket(weixin_key, scene_id, options)}"
  end

end
