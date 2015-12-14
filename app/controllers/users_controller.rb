class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]  
  before_action :current_user
  before_action :prevent_duplicate_sessions, only: [:new, :create]
   
  def new
    @user = User.new
  end
  
  def create
    params["user"]["role_id"] = user_id
    @user = User.new(user_params)
    if @user.save
      @user = login(@user.email, params["user"]["password"])
      redirect_to profile_path, :notice => "Thanks for signing up!"
    else
      render :new, :notice => "Unable to create your account."
    end
  end
  
  def edit
    @user = current_user
    @current_user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, :notice => "Account updated!"
    else
      render :edit, :notice => "Unable to update your account. #{@user.errors}"
    end
  end
  
  def show
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
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :profile_picture, :role_id)
  end
  
  def prevent_duplicate_sessions
    if @user
      redirect_to profile_path, :notice => "You are already logged in.  To create a new account, log out first."
    end
  end
  
end
