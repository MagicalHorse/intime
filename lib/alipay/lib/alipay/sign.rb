# encoding: utf-8
module Alipay
  module Sign
    def self.generate(params, md5_key = nil)
      query = params.sort.map do |key, value|
        "#{key}=#{value}"
      end.join('&')
      Digest::MD5.hexdigest("#{query}#{md5_key || Alipay.key}")
    end

    def self.verify?(params, md5_key = nil)
      params = Utils.stringify_keys(params)
      params.delete('sign_type')
      sign = params.delete('sign')

      generate(params, md5_key) == sign
    end
  end
end
