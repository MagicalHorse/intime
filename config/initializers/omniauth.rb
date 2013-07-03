Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, '2978041275', 'ea68b2a26ca930c6b51d434decdd2c9b'
  provider :qq_connect, '100382932','8acc22a900a6cf3a144c4e7364dafa78'
end