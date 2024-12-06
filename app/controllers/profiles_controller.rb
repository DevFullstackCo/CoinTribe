class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end


  def update_username
    @user = current_user
    if @user.update(username_params)
      redirect_to profile_path, notice: "Success"
    else
      flash[:alert] = "Impossible"
      redirect_to profile_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username)
  end
end

