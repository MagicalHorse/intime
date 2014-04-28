# encoding: utf-8
require 'test_helper'

class StoreCouponControllerTest < ActionController::TestCase
  test "should get consume" do
    get :consume
    assert_response :success
  end

end
