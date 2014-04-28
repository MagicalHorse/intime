# encoding: utf-8
require 'dalli'
module Cacheable
  def cache_get(key,expires,&block)
    dc = nil;
    cache_item = nil;
    if Rails.env.production?
      dc = Dalli::Client.new("#{Settings.elasticache.host}:#{Settings.elasticache.port}" \
                    , { :namespace => "i.intime.com.cn", :compress => true ,:expires_in => expires})
      cache_item = dc.fetch(key) do
        block.call 
      end
    else
      cache_item = block.call
    end
    cache_item
  end
end
