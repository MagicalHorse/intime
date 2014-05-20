# encoding: utf-8
Tire.configure do
  url Settings.elasticsearch_url
  logger "#{Rails.root}/log/elasticsearch.log", level: 'debug'
end

if Rails.env.production?
  ES_DEFAULT_INDEX = 'intimep'
  PIC_DOMAIN = 'http://irss.oss.aliyuncs.com/fileupload/img/' 
  AUDIO_DOMAIN = 'http://irss.oss.aliyuncs.com/fileupload/audio/' 

elsif Rails.env.stage?
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://111.207.166.195/fileupload/img/'
  AUDIO_DOMAIN = 'http://111.207.166.195/fileupload/audio/'
else
  ES_DEFAULT_INDEX = 'intime'
  PIC_DOMAIN = 'http://111.207.166.195/fileupload/img/'
  AUDIO_DOMAIN = 'http://111.207.166.195/fileupload/audio/'
end
