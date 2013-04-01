require 'test_helper'

class BannerControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

end
