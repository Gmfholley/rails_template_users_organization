class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  
  
  private
  # redirects user to login path
  #
  # returns nothing
  def not_authenticated
    redirect_to login_path, alert: "You are not logged in. Please log in."
  end
  
  # returns to profile path
  #
  # returns nothing
  def not_authorized
    redirect_to profile_path, alert: "You do not have access to view that page."
  end
  
  # if not an admin, redirects to not_admin path
  #
  # returns a boolean
  def handle_if_not_admin
    if is_admin?
      not_authorized
    end
  end
  
  # checks if current user is an admin
  #
  # returns boolean
  def is_admin?
    current_user.role.name != 'admin'
  end
  
  # finds Role id with a name of admin
  #
  # returns an integer
  def admin_id
    Role.find_by(name: 'admin').id
  end

  # finds Role id with a name of user
  #
  # returns an integer  
  def user_id
    Role.find_by(name: 'user').id
  end
  
  # checks if be
  #
  # returns an integer
  def belongs_to_organization
    if @organization.users.include?(current_user)
      redirect_to profile_path, notice: "You are not authorized to see another organization's page."
    end
  end
  
  def prevent_duplicate_sessions
    if @user
      redirect_to profile_path, :notice => "You are already logged in.  To create a new account, log out first."
    end
  end  
end
