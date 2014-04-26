# encoding: utf-8
module Alipay
  module Services
    module Direct
      module Refund
        class Web
          GATEWAY_URL = 'https://mapi.alipay.com/gateway.do'

          REQUIRED_OPTIONS = %w( service partner _input_charset sign_type sign seller_email refund_date batch_no batch_num detail_data )
          def self.url(options)
            options = {
              'service'             => 'refund_fastpay_by_platform_pwd',
              '_input_charset'      => 'utf-8',
              'partner'             => Alipay.pid,
              'seller_email'        => Alipay.seller_account,
              'refund_date'         => Time.now.strftime('%y-%m-%d %H:%M:%S')
            }.merge(Utils.stringify_keys(options))
            options['batch_num']    = options['detail_data'].to_s.split('#').size,
            options['sign']         = Sign.generate(options)
            options['sign_type']    = 'MD5'

            Utils.check_required_options(options, REQUIRED_OPTIONS)
            "#{GATEWAY_URL}?#{Utils.query_string(options)}"
          end
        end
      end
    end
  end
end
