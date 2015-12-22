require 'test_helper'

class ProfileControllerTest < ActionController::TestCase

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should update my profile" do
    request.env["HTTP_REFERER"] = profile_path
    @current_user = users(:susan)
    login_user(user = @current_user, route = login_path)

    patch :update, id: @current_user.id, user: {first_name: "changedName", last_name: @current_user.last_name, email: @current_user.email, password: "secret", password_confirmation: "secret" }

    assert_equal "changedName", @current_user.first_name
    assert_redirect_to profile_path
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
