require 'test_helper'

class FindWrapperControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get submit" do
    get :submit
    assert_response :success
  end

end
