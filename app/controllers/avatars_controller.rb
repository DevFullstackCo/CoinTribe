class AvatarsController < ApplicationController

    def create
        @user = current_user
  
        @user.avatar.attach(params[:avatar])
        redirect_to(profile_path(@user))
    end

end
