class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :avatar, :is_subscriber, :password, :password_confirmation)
    end
  end
  