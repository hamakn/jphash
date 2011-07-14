require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get hashnized" do
    get :hashnized
    assert_response :success
  end

end
