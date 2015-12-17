require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get create" do
    post :create
    assert_redirected_to login_path
  end

  test "should get edit" do
    get :edit, id: "string"
    assert_response :success
  end

  test "should get update" do
    patch :update, id: "string", user: {password: "changedName", password_confirmation: "changedName"}
    assert_redirected_to root_path
  end

end
