Tire.configure do
  url 'http://ec2-46-137-197-113.ap-southeast-1.compute.amazonaws.com:9200'
  logger "#{Rails.root}/log/elasticsearch.log", level: 'debug'
end

if Rails.env.production?
  ES_DEFAULT_INDEX = 'intimep'
  PIC_DOMAIN = 'http://r.youhuiin.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://r.youhuiin.com/fileupload/audio/' 
elsif Rails.env.stage?
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://apis.youhuiin.com/fileupload/img/'
  AUDIO_DOMAIN = 'http://apis.youhuiin.com/fileupload/audio/' 
else
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://apis.youhuiin.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://apis.youhuiin.com/fileupload/audio/' 
end