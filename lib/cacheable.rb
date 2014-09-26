# encoding: utf-8
require 'memcached'

module Cacheable
  def cache_get(key,expires,&block)
    dc = nil;
    cache_item = nil;
    if Rails.env.production?
        dc = client
        cache_item = dc.get(key)
    else
      cache_item = block.call
    end
    cache_item
  rescue Memcached::NotFound
    cache_value = block.call
    dc.set(key,cache_value,expires.to_i)
    retry
  end

  def client
    $memcached
  end
end
