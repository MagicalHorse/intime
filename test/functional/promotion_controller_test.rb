require 'test_helper'

class PromotionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
