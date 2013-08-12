RestClient.log = 'log/restclient.log'
if Rails.env.production?
  
elsif Rails.env.stage?
  
else
  API_HOST ="http://apis.youhuiin.com/api"
  CLIENT_VERSION = '2.3'
  API_KEY = 'yintai'
end