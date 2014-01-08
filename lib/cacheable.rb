require 'dalli'
module Cacheable
  def cache_get(key,expires)
    dc = nil;
    cache_item = nil;
    if Rails.env.production?
      dc = Dalli::Client.new("#{Settings.elasticache.host}:#{Settings.elasticache.port}", { :namespace => "i.intime.com.cn", :compress => true })
      cache_item = dc.get(key)
    end
    cache_item = yield if cache_item.nil?
    return cache_item unless cache_item.nil?   
    if Rails.env.production?
      dc = Dalli::Client.new("#{Settings.elasticache.host}:#{Settings.elasticache.port}", { :namespace => "i.intime.com.cn", :compress => true }) if dc.nil?
      dc.set(key,cache_item,expires)
    end
    cache_item
  end
end