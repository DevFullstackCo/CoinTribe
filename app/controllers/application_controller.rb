class ApplicationController < ActionController::Base
  before_action :set_user_favorites
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

    def set_user_favorites
      if user_signed_in?
        @favorites_for_menu = current_user.favorites.where(is_favorite: true).includes(:crypto)
        @total_balance = @favorites_for_menu.sum { |favorite| favorite.total_price }
      else
        @favorites_for_menu = []
        @total_balance = 0
      end
    end
end
