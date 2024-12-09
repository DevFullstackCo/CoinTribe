class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = current_user.favorites.find_or_initialize_by(crypto: @crypto) 

    if update_favorite(@favorite)
      flash[:notice] = "Crypto successfully added to your favorites!"
    else
      flash[:alert] = "Failed to add crypto to your favorites"
    end

    redirect_to crypto_path(@crypto)
  end

  private

  def update_favorite(favorite)
    @favorite.update(
      quantity: params[:quantity].presence || favorite.quantity || O,
      is_favorite: params[:is_favorite] == "true" # params[:is_favorite] is received as a string ("true" or "false"). The comparison ensures we convert this string into a boolean.
    )
  end
  
end
