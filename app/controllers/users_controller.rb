class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]  
  before_action :prevent_duplicate_sessions, only: [:new, :create]
  before_action :set_user, except: [:new, :create]
  before_action :has_authorization, except: [:new, :create, :show]
  before_action :set_organization, only: [:new, :create]
   
  def new
    if @organization.blank?
      @user = User.new
    else
      @user = @organization.users.build
    end
  end
  
  def create
    @user = User.new(user_params)
    if !@organization.blank?
      @user.organization = @organization
    end
        # for users who sign up through the portal, they should be set to users
    @user.role_id = user_id
    if @user.save
      @user = login(@user.email, params["user"]["password"])
      redirect_to profile_path, :notice => "Thanks for signing up!"
    else
      render :new, :notice => "Unable to create your account."  
    end
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, :notice => "Account updated!"
    else
      render :edit, :notice => "Unable to update the account. #{@user.errors}"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = current_user
    if @user.destroy
      redirect_to login_path, :notice => "Your account was deleted."
    else
      redirect_to profile_path, :notice => "Sorry.  Something went wrong.  Try again to delete your account."
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :profile_picture, :role_id, :organization_id)
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
