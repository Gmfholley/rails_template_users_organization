class OrganizationUsersController < ApplicationController
  before_action :set_change_user
  before_action :set_organization
  before_action :has_authorization
  before_action :set_organization_user
     
  def create
    
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find_by(token: params[:id])
  end
  
  def set_change_user
    @change_user = Organization.find(params[:user_id])
  end
  
  def set_organization_user
    @organization_user = OrganizationUser.find_by(user: @change_user, organization: @organization)
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_user_params
    params.require(:organization_user).permit(:user_id, :organization_id, :role_id)
  end
      
  def password_params
     params["organization"]["users_attributes"]["0"]["password"]
  end
end
