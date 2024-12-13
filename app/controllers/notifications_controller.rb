class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def mark_as_read
    current_user.notifications.where(is_read?: false).update_all(is_read?: true)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer || root_path, notice: '' }
    end
  end

  def destroy
    if current_user.notifications.destroy_all
      flash[:notice] = ""
    else
      flash[:alert] = ""
    end
    redirect_to notifications_path
  end
  
end
