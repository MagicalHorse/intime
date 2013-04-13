require 'test_helper'
require 'openssl'
require 'base64'
class StoreControllerTest < ActionController::TestCase
  fixtures :auth_keys
  test "index with authenticate" do
   data = {
        :id=>1
      }
    private_key = AuthKey.find_by_publickey_and_status(auth_keys(:one).publickey,1)
    digest = OpenSSL::Digest::Digest.new('sha1')
    ts = Time.now.utc
    nonce = rand(10000)
    sign_tobe = [auth_keys(:one).publickey,ts.to_s,nonce.to_s].sort.join
    sign_validate =  Base64.encode64(OpenSSL::HMAC.digest(digest, private_key.private, sign_tobe))
    get :index ,{:id=>1,:timestamp=>ts,:nonce=>nonce,:key=>auth_keys(:one).publickey,:sign=>sign_validate,:request=>data}
    assert_response :success
  

  end
  
  test "should authenticate expired" do
    data = {
        :id=>1
      }
    private_key = AuthKey.find_by_publickey_and_status(auth_keys(:one).publickey,1)
    digest = OpenSSL::Digest::Digest.new('sha1')
    ts = Time.now.utc-5.minutes
    sign_validate =  OpenSSL::HMAC.digest(digest, private_key.private, [auth_keys(:one).publickey,data.to_s,ts.to_s].sort.join)   
    get :index ,{:id=>1,:timestamp=>ts,:key=>auth_keys(:one).publickey,:sign=>sign_validate,:request=>data}
    assert_response :success
  end

end
