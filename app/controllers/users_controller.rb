class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]  
  before_action :prevent_duplicate_sessions, only: [:new, :create]
  before_action :set_user, only: [:update, :show]
  before_action :set_organization, only: [:new, :create]
  before_action :has_authorization, only: [:update, :show]
   
  def new
    if @organization.blank?
      @user = User.new
    else
      @user = @organization.users.build
    end
  end
  
  def create
    @user = User.create(user_params)
    
    if !@organization.blank? && !@user.id.blank?
      assoc = OrganizationUser.create(user: @user.id, organization: @organization.id, role_id: Role.user_id)
     if assoc.blank?
       render :new, :notice => "Unable to create your account."  
       @user.destroy
     else
       @user = login(@user.email, params["user"]["password"])
       redirect_to profile_path, :notice => "Thanks for signing up!"
     end 
    else
      # for users who sign up through the portal, they should be set to users
      if @user.id.  blank?
        render :new, :notice => "Unable to create your account."  
      else
        @user = login(@user.email, params["user"]["password"])
        redirect_to profile_path, :notice => "Thanks for signing up!"
      end
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to :back, :notice => "Account updated!"
    else
      redirect_to :back, :notice => "Unable to update the account. #{@user.errors}"
    end
  end
  
  def show
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :profile_picture)
  end
    
  def set_user
    @user = User.find(params[:id])
  end
  
  def has_authorization
    current_user == @user
  end
  
  def set_organization
    @organization = Organization.find_by(token: params[:id])
  end  
end
