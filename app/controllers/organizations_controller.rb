class OrganizationsController < ApplicationController
  skip_before_filter :require_login, only: [:edit, :update, :show, :destroy]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:edit, :update, :show, :destroy]
  
  def new
    @organization = Organization.new
  end
  
  def create
    params["organization"]["users_attributes"]["0"]["role_id"] = Role.find_by(name: 'admin').id
    @organization = Organization.new(organization_params)
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
      redirect_to organization_path(@organization.id), :notice => "Sorry.  Something went wrong.  We are unable to deleter your account."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :users_attributes => [:email, :first_name, :last_name, :password,  :password_confirmation, :role_id])
    end
end
