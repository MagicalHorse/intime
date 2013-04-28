require 'test_helper'

class V22::BannerControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

end
