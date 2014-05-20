# encoding: utf-8
RestClient.log = 'log/restclient.log'
PAGE_ALL_SIZE = 1000
if Rails.env.production?
  API_HOST = Settings.api.apis
  IMS_HOST = Settings.api.imsapi
  CLIENT_VERSION = '3.0'
  API_KEY = '4030D3A6-07FD-4BF4-93D8-564B950CC4A7'
  IMS_KEY = '4030D3A6-07FD-4BF4-93D8-564B950CC4A7'
elsif Rails.env.stage?
  
else
  API_HOST ="http://111.207.166.195/api"
  IMS_HOST ="http://111.207.166.195/ims"
  CLIENT_VERSION = '2.3'
  API_KEY = '7AB4F1BB-7E70-46CF-98E8-B97F841C30EA'
  IMS_KEY = '7AB4F1BB-7E70-46CF-98E8-B97F841C30EA'
end
