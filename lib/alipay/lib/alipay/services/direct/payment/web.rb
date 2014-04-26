# encoding: utf-8
module Alipay
  module Services
    module Direct
      module Payment
        class Web
          GATEWAY_URL = 'https://mapi.alipay.com/gateway.do'

          REQUIRED_OPTIONS = %w( service partner _input_charset out_trade_no subject payment_type seller_account_name )
          # direct
          def self.url(options)
            options = {
              'service'             => 'create_direct_pay_by_user',
              '_input_charset'      => 'utf-8',
              'partner'             => Alipay.pid,
              'seller_account_name' => Alipay.seller_account,
              'payment_type'        => '1'
            }.merge(Utils.stringify_keys(options))
            options['sign']         = Sign.generate(options)
            options['sign_type']    = 'MD5'

            Utils.check_required_options(options, REQUIRED_OPTIONS)

            if options['total_fee'].nil? and (options['price'].nil? || options['quantity'].nil?)
              raise RequiredArgumentError, "total_fee or (price && quantiry) must have one"
            end
            "#{GATEWAY_URL}?#{Utils.query_string(options)}"
          end
        end
      end
    end
  end
end
