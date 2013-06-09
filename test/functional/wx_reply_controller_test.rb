require 'test_helper'

class WxReplyControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

end
