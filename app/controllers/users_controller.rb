class UsersController < ApplicationController
  # skip_after_action :verify_authorized
  # skip_after_action :verify_policy_scoped

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def new
  end

  def create
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
  end

  def destroy
    authorize @user
  end
end
