Tire.configure do
  url 'http://ec2-46-137-197-113.ap-southeast-1.compute.amazonaws.com:9200'
  logger "#{Rails.root}/log/elasticsearch.log", level: 'debug'
end

if Rails.env.production?
  ES_DEFAULT_INDEX = 'intimep'
  PIC_DOMAIN = 'http://irss.ytrss.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://irss.ytrss.com/fileupload/audio/' 
elsif Rails.env.stage?
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://111.207.166.195/fileupload/img/'
  AUDIO_DOMAIN = 'http://111.207.166.195/fileupload/audio/' 
else
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://111.207.166.195/fileupload/img/' 
  AUDIO_DOMAIN = 'http://111.207.166.195/fileupload/audio/' 
end