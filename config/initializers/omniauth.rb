Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, '1136922935', 'cee745ae09ff0000428e0a52757ff175'
  provider :qq_connect, '100382932','8acc22a900a6cf3a144c4e7364dafa78'
  provider :tqq, '801302732', 'cd497771f88f6971ad11855088d050fd'
end
