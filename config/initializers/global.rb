$logger = Rails.env.prodcution? ? Logger.new("log/production.log") : Logger.new("log/development.log")

options = {
  prefix_key: "i.intime.com.cn"
}
if Rails.env.production?
  options.merge! credentials: [Settings.elasticache.username,Settings.elasticache.password]
end

$memcached = Memcached.new("#{Settings.elasticache.host}:#{Settings.elasticache.port}", options)