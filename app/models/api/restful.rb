require 'rest_client'
require 'digest/sha1'
module API
  
end
module API::Restful
    def post(req,params={})
      sessionid = req.session[:session_id]
      token = req.session[:user_token]
      value_signing = "#{API_KEY}client_version#{CLIENT_VERSION}uid#{sessionid}#{API_KEY}"
      sign_value = Digest::MD5.hexdigest(value_signing)
      params.merge!({:sign=>sign_value,:client_version=>CLIENT_VERSION,:uid=>sessionid,:token=>token})
      Rails.logger.info "#{API_HOST}"
      RestClient.post("#{API_HOST}/#{resource_name}", params, :accept=>:json){|response,request,result,&block|
        case response.code
        when 200
          JSON.parse(response.body).with_indifferent_access      
        when 500            
          Rails.logger.error response
          JSON.parse(response.body).with_indifferent_access
        else
          Rails.logger.error response
          {:isSuccessful=>false,
           :message=>'network problem!',
           :statusCode=>'500'
          }
        end 
       }
    end
end