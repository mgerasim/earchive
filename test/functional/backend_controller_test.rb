require 'test_helper'

class BackendControllerTest < ActionController::TestCase
  test "should get find_all_doctypes" do
    get :find_all_doctypes
    assert_response :success
  end

end
