RestClient.log = 'log/restclient.log'
PAGE_ALL_SIZE = 1000
if Rails.env.production?
  API_HOST ="http://iapi.intime.com.cn/api"
  CLIENT_VERSION = '3.0'
  API_KEY = '4030D3A6-07FD-4BF4-93D8-564B950CC4A7'
elsif Rails.env.stage?
  
else
  API_HOST ="http://apis.youhuiin.com/api"
  CLIENT_VERSION = '2.3'
  API_KEY = '7AB4F1BB-7E70-46CF-98E8-B97F841C30EA'
end