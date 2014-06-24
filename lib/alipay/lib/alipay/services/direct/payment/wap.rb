# encoding: utf-8
module Alipay
  module Services
    module Direct
      module Payment
        class Wap
          GATEWAY_URL = 'http://wappaygw.alipay.com/service/rest.htm'

          REQUEST_TOKEN_URL_REQUIRED_OPTIONS = %w( service format v partner req_id sec_id sign req_data )
          def self.request_token_url(options, md5_key = nil)
            options = {
              'service'         => 'alipay.wap.trade.create.direct',
              'format'          => 'xml',
              'v'               => '2.0',
              'partner'         => Alipay.pid,
              'req_id'          => "#{Time.now.strftime('%y%m%d%H%M%S')}#{rand(1000000).to_s.rjust(6, '0')}",
              'sec_id'          => 'MD5'
            }.update(Utils.stringify_keys(options))
            options['req_data'] = {
              'seller_account_name' => Alipay.seller_account,
              'root'                => 'direct_trade_create_req'
            }.update(Utils.stringify_keys(options['req_data'] || {}))
            Utils.check_required_options(options['req_data'], %w( subject out_trade_no total_fee seller_account_name call_back_url ))

            options['req_data'] = req_data(options['req_data'])
            options['sign']     = Sign.generate(options, md5_key)

            Utils.check_required_options(options, REQUEST_TOKEN_URL_REQUIRED_OPTIONS)
            url = "#{GATEWAY_URL}?#{Utils.query_string(options)}"
            Alipay.logger.debug("-----> #{Time.now.strftime('%y-%m-%d %H:%M:%S')} generate request_token_url: #{url}")
            url
          end

          AUTH_AND_EXECUTE_URL_REQUIRED_OPTIONS = %w( service format v partner req_id sec_id sign req_data )
          def self.auth_and_execute_url(options, md5_key = nil)
            options = {
              'service'         => 'alipay.wap.auth.authAndExecute',
              'format'          => 'xml',
              'v'               => '2.0',
              'partner'         => Alipay.pid,
              'req_id'          => "#{Time.now.strftime('%y%m%d%H%M%S')}#{rand(1000000).to_s.rjust(6, '0')}",
              'sec_id'          => 'MD5'
            }.update(Utils.stringify_keys(options))

            options['req_data'] = {
              'seller_account_name' => Alipay.seller_account,
              'root'                => 'auth_and_execute_req'
            }.update(Utils.stringify_keys(options['req_data'] || {}))
            Utils.check_required_options(options['req_data'], %w( request_token ))

            options['req_data'] = req_data(options['req_data'])
            options['sign']     = Sign.generate(options, md5_key)

            Utils.check_required_options(options, AUTH_AND_EXECUTE_URL_REQUIRED_OPTIONS)
            url = "#{GATEWAY_URL}?#{Utils.query_string(options)}"
            Alipay.logger.debug("-----> #{Time.now.strftime('%y-%m-%d %H:%M:%S')} generate auth_and_execute_url: #{url}")
            url
          end

          def self.url(options, md5_key = nil)
            auth_and_execute_url({partner: (options[:partner] || Alipay.pid), 'req_data' => { 'request_token' => get_request_token(options, md5_key) }}, md5_key)
          end

          private

          def self.req_data(options)
            root = options.delete('root')
            options.to_xml(:skip_types => true, :skip_instruct => true, :dasherize => false, :indent => 0, :root => root)
          end

          def self.get_request_token(options, md5_key = nil)
            result = Timeout.timeout(Alipay.timeout) { open(request_token_url(options, md5_key)).read }
            Alipay.logger.debug("-----> #{Time.now.strftime('%y-%m-%d %H:%M:%S')} request request_token result: #{result}")
            params = Rack::Utils.parse_query(result)

            if !params.key?('res_error') && Sign.verify?(params, md5_key)
              Hash.from_xml(params['res_data'])['direct_trade_create_res']['request_token']
            elsif params.key?('res_error')
              raise RequestError, params['res_error']
            else
              raise SignVerifyError, params.to_json
            end
          end
        end
      end
    end
  end
end
