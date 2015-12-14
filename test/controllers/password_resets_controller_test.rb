require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get create" do
    post password_resets_path
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: "string"
    assert_response :success
  end

  test "should get update" do
    
    patch :update, id: "string", password_resets: { id: "changedName" }
    put :update, password_resets: { id: "test"  }
    assert_response :success
  end

end
