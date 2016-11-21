require 'test_helper'

class ValidationControllerTest < ActionController::TestCase
  test "should get validation" do
    get :validation
    assert_response :success
  end

end
