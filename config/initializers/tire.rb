Tire.configure do
  url 'http://10.161.218.70:9200'
  logger "#{Rails.root}/log/elasticsearch.log", level: 'debug'
end

if Rails.env.production?
  ES_DEFAULT_INDEX = 'intimep'
  PIC_DOMAIN = 'http://irss.oss.aliyuncs.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://irss.oss.aliyuncs.com/fileupload/audio/' 
elsif Rails.env.stage?
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://apis.youhuiin.com/fileupload/img/'
  AUDIO_DOMAIN = 'http://apis.youhuiin.com/fileupload/audio/' 
else
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://apis.youhuiin.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://apis.youhuiin.com/fileupload/audio/' 
end