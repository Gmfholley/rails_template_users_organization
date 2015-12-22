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
  
  test "should show user profile page" do
    @current_user = users(:susan)
    login_user(user = @current_user, route = login_path)
    get :show, id: @current_user.id
    assert_response :success
  end
  
  
  test "should update user" do
    request.env["HTTP_REFERER"] = profile_path
    @current_user = users(:susan)
    login_user(user = @current_user, route = login_path)

    patch :update, id: @current_user.id, user: {first_name: "changedName", last_name: @current_user.last_name, email: @current_user.email, password: "secret", password_confirmation: "secret" }

    assert_equal "changedName", @current_user.first_name
    assert_redirect_to profile_path
  end
  
  
end
