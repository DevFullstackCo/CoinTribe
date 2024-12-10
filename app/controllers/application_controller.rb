class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_user_favorites
    if user_signed_in?
      @favorites_for_menu = current_user.favorites.where(is_favorite: true).includes(:crypto)
    end
  end
end
