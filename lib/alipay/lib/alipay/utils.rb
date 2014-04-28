# encoding: utf-8
module Alipay
  module Utils
    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        if value.is_a?(::Hash)
          new_hash[(key.to_s rescue key) || key] = stringify_keys(value)
        else
          new_hash[(key.to_s rescue key) || key] = value
        end
      end
      new_hash
    end

    def self.check_required_options(options, names)
      missings = []
      names.each do |name|
        missings << name unless options.has_key?(name)
      end
      raise(RequiredArgumentError, "missing required options: [#{missings.join(', ')}]") if missings.size > 0
    end

    def self.query_string(options)
      options.map do |key, value|
        "#{Rack::Utils.escape(key.to_s)}=#{Rack::Utils.escape(value.to_s)}"
      end.join('&')
    end
  end
end
