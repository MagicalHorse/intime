# encoding: utf-8
require 'test_helper'

class V22::HotwordControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

end
