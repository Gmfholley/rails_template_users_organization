require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @organization = organizations(:bank)
    @current_user = users(:susan)
    login_user(user = @current_user, route = login_path) 
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post :create, organization: { name: "test", :users_attributes => {"0" => {email: "test@test.com", first_name: "test", last_name: "test", password: "password", password_confirmation: "password"}}  }
    end

    assert_redirected_to organization_path(assigns(:organization).token)
  end

  test "should show organization" do
    get :show, id: @organization.token
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, id: @organization.token
    assert_response :success
  end

  test "should update organization" do
    patch :update, id: @organization.token, organization: { name: "changedName" }
    assert_equal assigns(:organization).name, "changedName"
    assert_redirected_to organization_path(@organization.token)
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization.token
    end

    assert_redirected_to login_path
  end  
end
