class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.new(favorites_params)
    @favorite.user = current_user
    @favorite.crypto = @crypto

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

    logger.debug "Params reçus : #{params.inspect}" # Debug des paramètres
    logger.debug "Favorite avant mise à jour : #{@favorite.inspect}" # Debug de l'objet avant mise à jour

    if @favorite&.update(favorites_params)
      logger.debug "Favorite après mise à jour : #{@favorite.inspect}"
      flash[:notice] = "Favorite successfully updated!"
    else
      logger.debug "Erreurs lors de la mise à jour : #{@favorite.errors.full_messages}"
      flash[:alert] = "Could not update favorite."
    end

    redirect_to crypto_path(params[:crypto_id])
  end

  def edit
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.find_by(user: current_user, crypto: @crypto) || Favorite.new(crypto: @crypto, user: current_user)
  end

  def destroy
    @favorite = Favorite.find(params[:id])

    if @favorite.destroy
      redirect_to crypto_path(@favorite.crypto), notice: "Removed from favorites!"
    else
      redirect_to crypto_path(@favorite.crypto), alert: "Could not remove favorite."
    end
  end

  private

  def favorites_params
    params.require(:favorite).permit(:quantity, :is_favorite)
  end
  
end
