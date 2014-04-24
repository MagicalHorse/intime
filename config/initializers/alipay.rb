# encoding: utf-8
require 'alipay/lib/alipay'
Alipay.pid            = Settings.alipay.pid
Alipay.key            = Settings.alipay.key
Alipay.seller_account = Settings.alipay.seller_account
Alipay.timeout        = Settings.alipay.timeout
Alipay.logger         = Rails.logger
