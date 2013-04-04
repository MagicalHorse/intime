Tire.configure do
  url 'http://ec2-46-137-197-113.ap-southeast-1.compute.amazonaws.com:9200'
  logger "#{Rails.root}/log/elasticsearch.log", level: 'debug'
end

if Rails.env.production?
  ES_DEFAULT_INDEX = 'intimep'
  PIC_DOMAIN = 'http://itoo.yintai.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://itoo.yintai.com/fileupload/audio/' 
elsif Rails.env.stage?
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://122.226.53.114:7070/fileupload/img/'
  AUDIO_DOMAIN = 'http://122.226.53.114:7070/fileupload/audio/' 
else
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://122.226.53.114:7070/fileupload/img/'
  AUDIO_DOMAIN = 'http://122.226.53.114:7070/fileupload/audio/' 
end