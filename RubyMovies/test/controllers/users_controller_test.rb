require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get promote" do
    get :promote
    assert_response :success
  end

end
