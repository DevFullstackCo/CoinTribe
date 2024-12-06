class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user

    @user.username(params[:avatar])
    redirect_to(profile_path(@user))
  end


end

