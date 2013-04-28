require 'test_helper'

class V22::SpecialTopicControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

end
