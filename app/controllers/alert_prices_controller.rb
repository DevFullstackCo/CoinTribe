class AlertPricesController < ApplicationController
  before_action :authenticate_user!, only: [:create]


  def create
    @crypto = Crypto.find(params[:crypto_id])
    @alert_price = AlertPrice.new(alert_prices_params)
    @alert_price.user = current_user
    @alert_price.crypto = @crypto

    if @alert_price.save
      flash[:notice] = "Price alert set successfully!"
    else
      flash[:alert] = "Failed to set price alert. Please try again. "
    end

    redirect_to crypto_path(@crypto)
  end


  def update
    @crypto = Crypto.find(params[:crypto_id])
    @alert_price = AlertPrice.find_by(user: current_user, crypto: @crypto)

    if @alert_price.update(alert_prices_params)
      flash[:notice] = "Price alert updated successfully!"
    else
      flash[:alert] = "Failed to update price alert. Please try again."
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

  def alert_prices_params
    params.require(:alert_price).permit(:price_up, :price_down)
  end

end
