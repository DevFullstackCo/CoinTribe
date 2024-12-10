class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.new(favorites_params)
    @favorite.user = current_user
    @favorite.crypto = @crypto

    adjust_quantity_for_favorite(@favorite)

    if @favorite.save
      flash[:notice] = "Crypto successfully added to your favorites!"
    else
      flash[:alert] = "Failed to add crypto to your favorites."
    end
  
    redirect_to crypto_path(@crypto)
  end


  def update
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.find_by(user: current_user, crypto: @crypto)

    @favorite.assign_attributes(favorites_params)
    adjust_quantity_for_favorite(@favorite)

    if @favorite.save
      flash[:notice] = "Favorite successfully updated!"
    else
      flash[:alert] = "Could not update favorite."
    end

    redirect_to crypto_path(params[:crypto_id])
  end


  def edit
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.find_by(user: current_user, crypto: @crypto) || Favorite.new(crypto: @crypto, user: current_user)
  end

  
  private

  def favorites_params
    params.require(:favorite).permit(:quantity, :is_favorite)
  end

  def adjust_quantity_for_favorite(favorite)
    favorite.quantity = 0 unless favorite.is_favorite
  end
  
end
