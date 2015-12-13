class OrganizationsUsersController < ApplicationController
  before_action :set_organizations_user, only: [:show, :edit, :update, :destroy]

  # GET /organizations_users
  # GET /organizations_users.json
  def index
    @organizations_users = OrganizationsUser.all
  end

  # GET /organizations_users/1
  # GET /organizations_users/1.json
  def show
  end

  # GET /organizations_users/new
  def new
    @organizations_user = OrganizationsUser.new
  end

  # GET /organizations_users/1/edit
  def edit
  end

  # POST /organizations_users
  # POST /organizations_users.json
  def create
    @organizations_user = OrganizationsUser.new(organizations_user_params)

    respond_to do |format|
      if @organizations_user.save
        format.html { redirect_to @organizations_user, notice: 'Organizations user was successfully created.' }
        format.json { render :show, status: :created, location: @organizations_user }
      else
        format.html { render :new }
        format.json { render json: @organizations_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations_users/1
  # PATCH/PUT /organizations_users/1.json
  def update
    respond_to do |format|
      if @organizations_user.update(organizations_user_params)
        format.html { redirect_to @organizations_user, notice: 'Organizations user was successfully updated.' }
        format.json { render :show, status: :ok, location: @organizations_user }
      else
        format.html { render :edit }
        format.json { render json: @organizations_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations_users/1
  # DELETE /organizations_users/1.json
  def destroy
    @organizations_user.destroy
    respond_to do |format|
      format.html { redirect_to organizations_users_url, notice: 'Organizations user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organizations_user
      @organizations_user = OrganizationsUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organizations_user_params
      params[:organizations_user]
    end
end
