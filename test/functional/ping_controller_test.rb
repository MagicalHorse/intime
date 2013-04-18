require 'test_helper'
require 'openssl'
require 'base64'
class PingControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "the mock with test public key" do
    private_key = auth_keys(:one).private
    public = auth_keys(:one).publickey
    ts = Time.now.utc
    nonce= rand 10000
     digest = OpenSSL::Digest::Digest.new('sha1')
    sign_tobe = [public,nonce.to_s,ts.to_s].sort.join
    sign_validate =  Base64.encode64(OpenSSL::HMAC.digest(digest, private_key, sign_tobe))
    post(:mock,:timestamp=>ts.to_s,:nonce=>nonce,:sign=>sign_validate,:key=>public)
    Rails.logger.info response.body
    assert_response :success
  end
end
