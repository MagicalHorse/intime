RestClient.log = 'log/restclient.log'
if Rails.env.production?
  
elsif Rails.env.stage?
  
else
  API_HOST ="http://apis.youhuiin.com/api"
  CLIENT_VERSION = '2.3'
  API_KEY = '7AB4F1BB-7E70-46CF-98E8-B97F841C30EA'
end