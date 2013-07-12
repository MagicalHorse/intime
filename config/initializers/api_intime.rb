RestClient.log = 'log/restclient.log'
if Rails.env.production?
  
elsif Rails.env.stage?
  
else
  API_HOST ="http://apis.youhuiin.com/api"
  CLIENT_VERSION = '2.1.2'
  API_KEY = 'yintai123456'
end