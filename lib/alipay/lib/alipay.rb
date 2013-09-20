$LOAD_PATH.unshift(File.dirname(__FILE__))
require "alipay/version"
require 'alipay/sign'
require 'alipay/utils'
require 'alipay/notify'
require 'alipay/service/direct/wap'
require 'alipay/service/direct/web'

module Alipay
  class << self
    attr_accessor :pid
    attr_accessor :key
    attr_accessor :seller_account
  end
end
