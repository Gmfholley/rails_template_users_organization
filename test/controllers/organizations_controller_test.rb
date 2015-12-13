require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @organization = organizations(:bank)
    @user = users(:susan)
    login_user(user = @user, route = login_url) 
  end
  
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

  test "should show organization" do
    get :show, id: @organization
    assert_response :success
    # @user = users(:david)
    # login_user(user = @user, route = login_url)
    # get :show, id: @organization
    # assert_redirected_to profile_path
  end

  test "should get edit" do
    get :edit, id: @organization
    assert_response :success
  end

  test "should update organization" do
    patch :update, id: @organization, organization: { name: "changedName" }
    assert_redirected_to organization_path(@organization)
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization
    end

    assert_redirected_to login_path
  end
end
