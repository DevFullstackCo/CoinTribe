class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def update
      @user = current_user

      if @user.update(user_params)
        redirect_to profile_path(@user), notice: 'Profile image updated successfully!'
      else
        render :show, alert: 'Failed to update profile image.'
      end
    end

    private

    def user_params
      params.require(:user).permit(:avatar)
    end

end
  
