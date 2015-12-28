require 'test_helper'

class OrganizationUsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @organization = organizations(:bank)
    @current_user = users(:susan)
  end
  
  test "should get new" do
    get :new, id: @organization.token, user_id: @current_user.id
    assert_response :success
  end
  
  test "should get create" do 
    assert_difference('User.count') do
      post :create, id: @organization.token, user_id: @current_user.id, organization_user: { organization_id: @organization.id, user_id: @user.id }
    end
    assert_response :success    
  end
  
  test "should get update" do
    put :update, id: @organization.token, user_id: @current_user.id, organization_user: { organization_id: @organization.id, user_id: @user.id }
    assert_response :success
  end
  
  test "should get destroy" do 
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization.token, user_id: @current_user.id, organization_user: { organization_id: @organization.id, user_id: @user.id }
    end
    assert_response :success    
  end
  
  
end
