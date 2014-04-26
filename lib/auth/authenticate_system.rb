# encoding: utf-8
require 'openssl'
require 'base64'
require 'cgi'

module ISAuthenticate
  protected
  def auth_api
    time_stamp = params[:timestamp]
    return if !validate_ts?(time_stamp)
  end
  
  def auth_api2
    ts = params[:timestamp]
    key_in = params[:key]
    nonce = params[:nonce]
    sign = params[:sign]
    return if !validate_ts2?(ts,key_in,nonce,sign)
  end

  private
  def validate_ts2?(ts,key_in,nonce,sign)   
    error_msg = nil
    if ts.nil?
      error_msg ='no timestamp!'
#    elsif !DateTime.strptime(ts.to_s,'%s').between?((Time.now-2.minutes).utc,(Time.now+2.minutes).utc)
#      error_msg = 'timestamp expired'
    elsif key_in.nil?
      error_msg='no key contained'
    elsif nonce.nil?
      error_msg='rand expired!'
    else
      sign_in = sign.to_s
      private_key = AuthKey.find_by_publickey_and_status key_in,1
      if private_key.nil?
        error_msg = 'key not valid!'
      else
        digest = OpenSSL::Digest::Digest.new('sha1')
        sign_tobe = [key_in,ts.to_s,nonce].join
        sign_validate =  Base64.encode64(OpenSSL::HMAC.digest(digest, private_key.private, sign_tobe)).chomp
        error_msg = 'sign not valid!' unless sign_validate.to_s==sign_in
        Rails.logger.info "signed:#{sign_validate} vs passed:#{sign_in}" unless sign_validate.to_s.==sign_in
        Rails.logger.info "signed:#{sign_validate.length} vs passed:#{sign_in.length}" unless sign_validate.to_s.==sign_in
      end
    end
    if error_msg.nil?
    true
    else
      render :json=>{:isSuccessful=>false,
      :message =>error_msg,
      :statusCode =>'500'}
    false
    end

  end
  def validate_ts?(ts)
    error_msg = nil
    key_in = params[:key]
    nonce = params[:nonce]
    if ts.nil?
      error_msg ='no timestamp!'
   # elsif !ts.to_time.between?((Time.now-2.minutes).utc,(Time.now+2.minutes).utc)
   #   error_msg = 'timestamp expired'
    elsif key_in.nil?
      error_msg='no key contained'
    elsif nonce.nil?
      error_msg='rand expired!'
    else
      sign_in = params[:sign].to_s
      private_key = AuthKey.find_by_publickey_and_status key_in,1
      if private_key.nil?
        error_msg = 'key not valid!'
      else
        digest = OpenSSL::Digest::Digest.new('sha1')
        sign_tobe = [key_in,nonce,ts.to_s].sort.join
        sign_validate =  Base64.encode64(OpenSSL::HMAC.digest(digest, private_key.private, sign_tobe)).chomp
        error_msg = 'sign not valid!' unless sign_validate.to_s==sign_in
        Rails.logger.info "signed:#{sign_validate.hash} vs passed:#{sign_in.hash}" unless sign_validate.to_s.==sign_in
        Rails.logger.info "signed:#{sign_validate.length} vs passed:#{sign_in.length}" unless sign_validate.to_s.==sign_in
      end
    end
    if error_msg.nil?
    true
    else
      render :json=>{:isSuccessful=>false,
      :message =>error_msg,
      :statusCode =>'500'}
    false
    end

  end
end
