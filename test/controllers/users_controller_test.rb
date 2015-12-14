require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  # setup do
  #   @current_use = users(:susan)
  #   login_user(user = @current_user, route = login_path)
  # end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create organization" do
    assert_difference('Organization.count') do
      post :create, organization: { name: "test"  }
    end

    assert_redirected_to organization_path(assigns(:organization))
  end
  
  
end
