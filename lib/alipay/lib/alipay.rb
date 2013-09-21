$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rack/utils'
require 'digest/md5'
require 'open-uri'
require 'timeout'
require "alipay/version"
require "alipay/logger"
require "alipay/errors"
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
    # unit second
    attr_accessor :timeout
    attr_accessor :logger

    def logger
      @logger ||= Logger.new
    end
  end
end
