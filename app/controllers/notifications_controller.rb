class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def mark_as_read
    current_user.notifications.where(is_read?: false).update_all(is_read?: true)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer || root_path, notice: 'Notifications marquées comme lues.' }
    end
  end
end
