class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :require_login
  
  
  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
  
  def not_admin
    redirect_to profile_path, alert: "You do not have access to view that page."
  end
  
  def is_admin?
    if current_user.role.name != 'admin'
      not_admin
    end
  end
end
