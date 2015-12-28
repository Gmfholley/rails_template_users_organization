require 'test_helper'

class OrganizationUsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @organization_new = organizations(:factory)
    @organization_current = organizations(:bank)
    @current_user = users(:susan)
    login_user(user = @current_user, route = login_path) 
    request.env["HTTP_REFERER"] = profile_path
  end
  
  test "should get new" do
    get :new, id: @organization_new.token, user_id: @current_user.id
    assert_response :success
  end
  
  test "should get create" do 
    assert_difference('OrganizationUser.count', 1) do
      post :create, id: @organization_new.token, user_id: @current_user.id, organization_user: { organization_id: @organization_new.id, user_id: @current_user.id }
    end
    assert_redirected_to :back    
  end
  
  test "should get update" do
    put :update, id: @organization_current.token, user_id: @current_user.id, organization_user: { organization_id: @organization_current.id, user_id: @current_user.id }
    assert_redirected_to :back    
  end
  
  test "should get destroy" do 
    assert_difference('OrganizationUser.count', -1) do
      delete :destroy, id: @organization_current.token, user_id: @current_user.id, organization_user: { organization_id: @organization_current.id, user_id: @current_user.id }
    end
    assert_redirected_to :back    
  end
  
  
end
