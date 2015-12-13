require 'test_helper'

class OrganizationsUsersControllerTest < ActionController::TestCase
  setup do
    @organizations_user = organizations_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organizations_user" do
    assert_difference('OrganizationsUser.count') do
      post :create, organizations_user: {  }
    end

    assert_redirected_to organizations_user_path(assigns(:organizations_user))
  end

  test "should show organizations_user" do
    get :show, id: @organizations_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organizations_user
    assert_response :success
  end

  test "should update organizations_user" do
    patch :update, id: @organizations_user, organizations_user: {  }
    assert_redirected_to organizations_user_path(assigns(:organizations_user))
  end

  test "should destroy organizations_user" do
    assert_difference('OrganizationsUser.count', -1) do
      delete :destroy, id: @organizations_user
    end

    assert_redirected_to organizations_users_path
  end
end
