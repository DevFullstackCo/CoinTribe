class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.find_or_initialize_by(user: current_user, crypto: @crypto)
    @favorite.is_favorite = true
    @favorite.quantity = favorites_params[:quantity] if favorites_params[:quantity].present?

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

    if @favorite
      @favorite.assign_attributes(favorites_params)

      if @favorite.save
        flash[:notice] = "Favorite successfully updated!"
      else
        flash[:alert] = "Could not update favorite."
      end
    else
      flash[:alert] = "Favorite not found."
    end

    redirect_to crypto_path(params[:crypto_id])
  end

  def edit
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.find_or_initialize_by(user: current_user, crypto: @crypto)
  end

  def destroy
    @crypto = Crypto.find(params[:crypto_id])
    @favorite = Favorite.find_by(user: current_user, crypto: @crypto)

    if @favorite.destroy
      flash[:notice] = "Crypto successfully removed from your favorites."
    else
      flash[:alert] = "Failed to remove crypto from your favorites."
    end

    redirect_to crypto_path(@crypto)
  end

  def destroy
    @alert_price = current_user.alert_prices.find_by(crypto_id: params[:crypto_id])

    if @alert_price&.destroy
      flash[:notice] = "Price alert removed successfully."
    else
      flash[:alert] = "Failed to remove price alert."
    end

    redirect_to crypto_path(params[:crypto_id])
  end

  private

  def favorites_params
    params.require(:favorite).permit(:quantity)
  end
end