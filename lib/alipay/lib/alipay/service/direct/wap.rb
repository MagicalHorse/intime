require 'cgi'
require 'open-uri'

module Alipay
  module Service
    module Direct
      class Wap
        GATEWAY_URL = 'http://wappaygw.alipay.com/service/rest.htm'

        TOKEN_URL_REQUIRED_OPTIONS = %w( service format v partner req_id sec_id sign req_data )
        def self.token_url(options)
          options = {
            'service'         => 'alipay.wap.trade.create.direct',
            'format'          => 'xml',
            'v'               => '2.0',
            'partner'         => Alipay.pid,
            'req_id'          => "#{Time.now.strftime('%y%m%d%H%M%S')}#{rand(1000000).to_s.rjust(6, '0')}",
            'sec_id'          => 'MD5'
          }.merge(Utils.stringify_keys(options))

          options['req_data'] = {
            'seller_account_name' => Alipay.seller_account,
            'root'                => 'direct_trade_create_req'
          }.merge(Utils.stringify_keys(options['req_data'] || {}))
          Utils.check_required_options(options['req_data'], %w( subject out_trade_no total_fee seller_account_name call_back_url ))

          options['req_data'] = req_data(options['req_data'])
          options['sign']     = Sign.generate(options)

          Utils.check_required_options(options, TOKEN_URL_REQUIRED_OPTIONS)
          "#{GATEWAY_URL}?#{Utils.query_string(options.merge('except_escape_keys' => ['req_data']))}"
        end

        AUTH_AND_EXECUTE_URL_REQUIRED_OPTIONS = %w( service format v partner req_id sec_id sign req_data )
        def self.auth_and_execute_url(options)
          options = {
            'service'         => 'alipay.wap.auth.authAndExecute',
            'format'          => 'xml',
            'v'               => '2.0',
            'partner'         => Alipay.pid,
            'req_id'          => "#{Time.now.strftime('%y%m%d%H%M%S')}#{rand(1000000).to_s.rjust(6, '0')}",
            'sec_id'          => 'MD5'
          }.merge(Utils.stringify_keys(options))

          options['req_data'] = {
            'seller_account_name' => Alipay.seller_account,
            'root'                => 'auth_and_execute_req'
          }.merge(Utils.stringify_keys(options['req_data'] || {}))
          Utils.check_required_options(options['req_data'], %w( request_token ))

          options['req_data'] = req_data(options['req_data'])
          options['sign']     = Sign.generate(options)

          Utils.check_required_options(options, AUTH_AND_EXECUTE_URL_REQUIRED_OPTIONS)
          "#{GATEWAY_URL}?#{Utils.query_string(options.merge('except_escape_keys' => ['req_data']))}"
        end

        def self.req_data(options)
          root = options.delete('root')
          options.to_xml(:skip_types => true, :skip_instruct => true, :dasherize => false, :indent => 0, :root => root)
        end
      end
    end
  end
end
