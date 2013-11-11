require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get user" do
    get :user
    assert_response :success
  end

end
