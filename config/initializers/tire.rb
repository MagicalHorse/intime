Tire.configure do
  url 'http://ec2-46-137-197-113.ap-southeast-1.compute.amazonaws.com:9200'
  logger "#{Rails.root}/log/elasticsearch.log", level: 'debug'
end

if Rails.env.production?
  ES_DEFAULT_INDEX = 'intimep'
else
  ES_DEFAULT_INDEX = 'intimep'
end