Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, Settings.omniauth.weibo.key, Settings.omniauth.weibo.secret
  provider :qq_connect, Settings.omniauth.qq_connect.key, Settings.omniauth.qq_connect.secret
  provider :tqq2, Settings.omniauth.tqq.key, Settings.omniauth.tqq.secret
  provider :wechat, Settings.omniauth.wechat.key, Settings.omniauth.wechat.secret
end

if Rails.env.production?
  OmniAuth.config.on_failure = Proc.new do |env|
    [302, {'Location' => '/', 'Content-Type'=> 'text/html'}, []]
  end
end
