class OrganizationsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  before_action :prevent_duplicate_sessions, only: [:new, :create]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:edit, :update, :destroy]
  before_action :belongs_to_organization?, only: [:edit, :update, :show, :destroy]
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(organization_params)
    # for new organizations, make the creator the admin
    @organization.users.first.role_id = admin_id
    if @organization.save
      @user = login(params["organization"]["users_attributes"]["0"]["email"], params["organization"]["users_attributes"]["0"]["password"])
      redirect_to organization_path(@organization.id), :notice => "Thanks for signing up!"
    else
      render :new, :notice => "Unable to create a new organization."
    end
  end
  
  def edit
  end
  
  def update
    if @organization.update(organization_params)
      redirect_to organization_path(@organization.id), :notice => "Account updated!"
    else
      render :edit, :notice => "Unable to update your account."
    end
  end
  
  def show
  end
  
  def destroy
    if @organization.destroy
      redirect_to login_path, :notice => "Your account was deleted."
    else
      redirect_to organization_path(@organization.id), :notice => "Sorry.  Something went wrong.  We are unable to delete the account."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end
    
    def belongs_to_organization?
      if !@organization.users.include?(current_user)
        redirect_to profile_path, notice: "You are not authorized to see another organization's page."
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :users_attributes => [:email, :first_name, :last_name, :password,  :password_confirmation, :role_id])
    end
    
    def prevent_duplicate_sessions
      if @user
        redirect_to profile_path, :notice => "You are already logged in.  To create a new account, log out first."
      end
    end
end
