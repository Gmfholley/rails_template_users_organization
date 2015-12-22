class OrganizationsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  before_action :prevent_duplicate_sessions, only: [:new, :create]
  before_action :set_organization, except: [:new, :create]
  before_action :handle_if_not_admin, only: [:edit, :update, :destroy]
  before_action :handle_if_not_member, only: [:edit, :update, :show, :destroy]
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(organization_params)
    @user = @organization.users.first
    # for new organizations, make the creator the admin
    @organization.organization_users.first.role_id = Role.admin_id
    if @organization.save
      @user = login(@user.email,password_params)
      redirect_to organization_path(@organization.token), :notice => "Thanks for signing up!"
    else
      @user.destroy
      render :new, :notice => "Unable to create a new organization."
    end
  end
  
  def edit
  end
  
  def update
    if @organization.update(organization_params)
      redirect_to organization_path(@organization.token), :notice => "Account updated!"
    else
      render :edit, :notice => "Unable to update your account."
    end
  end
  
  def show
    @user = current_user
    @is_admin = is_admin?
  end
  
  def destroy
    if @organization.destroy
      redirect_to login_path, :notice => "Your account was deleted."
    else
      redirect_to organization_path(@organization.token), :notice => "Sorry.  Something went wrong.  We are unable to delete the account."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find_by(token: params[:id])
    end
        
    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :users_attributes => [:email, :first_name, :last_name, :password,  :password_confirmation])
    end
        
    def password_params
       params["organization"]["users_attributes"]["0"]["password"]
    end
end
