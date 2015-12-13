class OrganizationsUsersController < ApplicationController
  before_action :set_organization

  # GET /organizations_users
  # GET /organizations_users.json
  def index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end
  end
