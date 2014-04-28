# encoding: utf-8
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, Settings.omniauth.weibo.key, Settings.omniauth.weibo.secret
  provider :qq_connect, Settings.omniauth.qq_connect.key, Settings.omniauth.qq_connect.secret
  provider :tqq2, Settings.omniauth.tqq.key, Settings.omniauth.tqq.secret
  provider :wechat, Settings.omniauth.wechat.key, Settings.omniauth.wechat.secret
end
OmniAuth.config.logger = Rails.logger
#if Rails.env.production?

  OmniAuth.config.on_failure = Proc.new do |env|
    Rails.logger.error(env['omniauth.error'])
    [302, {'Location' => '/', 'Content-Type'=> 'text/html'}, []]
  end

#end
