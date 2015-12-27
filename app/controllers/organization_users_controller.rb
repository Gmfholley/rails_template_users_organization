class OrganizationUsersController < ApplicationController
  before_action :set_organization_user
  before_action :has_authorization
     
  def create
    @organization_user.role = Role.user
    if @organization_user.create
      respond_to do |format|
        format.json { render :json => @organization_user, status: :success }
      end
    else
      respond_to do |format|
        format.json { render :json => @organization_user.errors, status: :failure }
      end
    
    end
  end
  
  def update
    if @organization_user.update(organization_user_params)
      respond_to do |format|
        format.json { render :json => @organization_user, status: :success }
      end
    else
      respond_to do |format|
        format.json { render :json => @organization_user.errors, status: :failure }
      end
    end
  end
  
  def destroy
    if @organization_user.destroy
      respond_to do |format|
        format.json { render :nothing, status: :no_content }
      end
    else
      respond_to do |format|
        format.json { render :json => @organization_user.errors, status: :failure }
      end
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find_by(token: params[:id])
  end
  
  # sets the current user
  # Note: if there is no params[:user_id], then the user to change is the current user
  #
  # returns the user to change
  def set_change_user
    if params[:user_id].blank?
      @change_user = current_user
    else
      @change_user = Organization.find(params[:user_id])
    end
  end
  
  def set_organization_user
    set_change_user
    set_organization
    @organization_user = OrganizationUser.find_by(user: @change_user, organization: @organization)
  end
  
  def change_user_is_current_user?
    @change_user == current_user
  end
  
  def attempting_to_make_an_admin?
    params[:organization_users][:role_id] == Role.admin.id
  end
  
  
  # if you are an admin
  # if you are the current user && you are not attempting to make yourself an admin
  # ==> authorized
  
  # Not authorized
  # If you are not an admin nor are you the current user
  
  # 1. An Admin
  # 2. A current user
  # 3. a different user, not an admin
  #
  # if not an admin && not a current user
  # 1. false && true or false => false => authorized
  # 2. true && false => false => authorized
  # 3. true && true => true => not authorized 
  
  # if not an admin or the user him/herself, redirects to not_authorized path
  #
  # returns nothing
  def has_authorization
    if !is_admin? && !change_user_is_current_user?
      if attempting_to_make_an_admin? && !is_admin?
        not_authorized
      end
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_user_params
    params.require(:organization_user).permit(:user_id, :organization_id, :role_id)
  end
end
