require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get create" do
    post :create
    assert_redirected_to login_path
  end

  test "should get edit" do
    get :edit, id: "ARealResetToken"
    assert_response :success
    
    get :edit, id: "notARealToken"
    assert_redirected_to login_path
  end

  test "should get update" do
    patch :update, id: "string", user: {password: "changedName", password_confirmation: "changedName"}
    assert_redirected_to login_path
  end

end
