require 'test_helper'

class OracleControllerTest < ActionController::TestCase
  test "should get generate_mongo_doc" do
    get :simple_table
    assert_response :success
  end

  test "should get dump_script" do
    get :dump_script
    assert_response :success
  end

end
