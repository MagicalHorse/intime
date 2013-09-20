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
      fail(ArgumentError, "Ailpay Error: missing required options: [#{missings.join(', ')}]") if missings.size > 0
    end

    def self.query_string(options)
      except_escape_keys = options.delete('except_escape_keys') || []
      options.map do |key, value|
        "#{CGI.escape(key.to_s)}=#{except_escape_keys.include?(key) ? value.to_s : CGI.escape(value.to_s)}"
      end.join('&')
    end
  end
end
