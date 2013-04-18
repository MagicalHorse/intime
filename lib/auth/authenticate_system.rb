require 'openssl'
require 'base64'

module ISAuthenticate
  protected
  def auth_api
    time_stamp = params[:timestamp]
    return if !validate_ts?(time_stamp)
  end
  
  private
  def validate_ts?(ts)
    error_msg = nil
    key_in = params[:key]
    nonce = params[:nonce]
    if ts.nil?
      error_msg ='no timestamp!'
    elsif !ts.to_time.between?((Time.now-2.minutes).utc,(Time.now+2.minutes).utc)
      error_msg = 'timestamp expired'
    elsif key_in.nil?
      error_msg='no key contained'
    elsif nonce.nil?
      error_msg='rand expired!'
    else
      sign_in = params[:sign]
      private_key = AuthKey.find_by_publickey_and_status key_in,1
      if private_key.nil?
        error_msg = 'key not valid!'
      else
        digest = OpenSSL::Digest::Digest.new('sha1')
        sign_tobe = [key_in,nonce,ts.to_s].sort.join
        sign_validate =  Base64.encode64(OpenSSL::HMAC.digest(digest, private_key.private, sign_tobe))
        error_msg = 'sign not valid!' unless sign_validate.to_s == sign_in.to_s
      end
    end
    if error_msg.nil?
    true
    else
      logger.info error_msg
      render :json=>{:isSuccessful=>false,
      :message =>error_msg,
      :statusCode =>'500'}
    false
    end

  end
end