class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to profile_path, notice: 'Profile updated successfully!'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      current_user.destroy
      redirect_to root_path, notice: 'Your account has been deleted.'
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :avatar, :is_subscriber, :password, :password_confirmation)
    end
  end
  