  class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def update
      @user = current_user
    
      if @user.update_without_password(user_params)
        flash[:notice] = "Username updated successfully!"
        redirect_to profile_path
      else
        flash[:alert] = @user.errors.full_messages.join(", ")
        render :show
      end
    end
    
  
    private
  
    def user_params
      params.require(:user).permit(:username)
    end
  end
