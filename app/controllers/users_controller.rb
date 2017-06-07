class UsersController < ApplicationController
  # skip_after_action :verify_authorized
  # skip_after_action :verify_policy_scoped
  before_action :set_active_user, only: [:show, :edit, :update]

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :description, :profile_picture, :cover_photo)
  end

  def set_active_user
    @user = current_user
  end

end
