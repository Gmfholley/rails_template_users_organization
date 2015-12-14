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
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "test@t.com", first_name: "test", last_name: "test", password: "password", password_confirmation: "password" }
    end

    assert_redirected_to profile_path
  end
  
  test "should show organization" do
    @current_user = users(:susan)
    login_user(user = @current_user, route = login_path)
    get :show, id: @current_user.id
    assert_response :success
  end
  
  
end
