# encoding: utf-8
require 'rest_client'
require 'digest/sha1'
module API
  module Restful

    def post(req, params = {})
      options       = params.dup.symbolize_keys
      path          = options.delete :path
      sessionid     = req.session[:session_id] || Time.now.to_i
      token         = req.session[:user_token]
      sign_value    = Digest::MD5.hexdigest("#{API_KEY}client_version#{CLIENT_VERSION}uid#{sessionid}#{API_KEY}")
      options.merge!(sign: sign_value, client_version: CLIENT_VERSION, channel: 'html5', uid: sessionid, token: token)
      Rails.logger.debug "-----> request #{API_HOST}/#{path}"
      RestClient.post("#{API_HOST}/#{path}", options, accept: :json) { |response, request, result, &block|
        case response.code
        when 200
          JSON.parse(response.body).with_indifferent_access
        when 500
          Rails.logger.error response
          JSON.parse(response.body).with_indifferent_access
        else
          Rails.logger.error response
          { isSuccessful: false, message: 'network problem!', statusCode: '500' }
        end
      }
    end
  end
end
