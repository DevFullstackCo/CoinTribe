class NotificationsController < ApplicationController
  before_action :authenticate_user!


  def mark_as_read
    current_user.notifications.where(is_read?: false).update_all(is_read?: true)
  end

end
