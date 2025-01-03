  class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def update
      @user = current_user
    
      new_username = params[:user][:username]

      if User.exists?(username: new_username) && new_username != @user.username
        flash[:alert] = "This username is already taken. Please choose another one."
        render :show and return
      end

      if @user.update_without_password(user_params)
        flash[:notice] = "Username updated successfully!"
        redirect_to profile_path
      else
        flash[:alert] = @user.errors.full_messages.join(", ")
        render :show
      end
    end
    
    def search
      @user = current_user

      if params[:query].present?
        query = "%#{params[:query]}%"
        @searched_users = User.where("email ILIKE ? OR username ILIKE ?", query, query)
      else
        @searched_users = []
        flash[:alert] = "Please enter a value to search."
      end

      respond_to do |format|
        format.turbo_stream { render :search }
        format.html { render :show }
      end
    end
  

    def delete_user
      
      user = User.find(params[:id])

      if current_user.is_admin == true
        if user.destroy
          flash[:success] = "User successfully deleted."
        else
          flash[:error] = "An error occurred during deletion."
        end
      else
        flash[:alert] = "Access denied."
      end

      redirect_to profile_path
    end

    private
  
    def user_params
      params.require(:user).permit(:username)
    end
  end
