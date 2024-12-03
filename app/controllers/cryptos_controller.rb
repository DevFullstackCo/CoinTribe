class CryptosController < ApplicationController
  def index
    if params[:search].present?
      @cryptos = Crypto.search_by_name_or_symbol(params[:search])
    else
      @cryptos = Crypto.limit(5)
    end

    respond_to do |format|
      format.html # Vue classique
      format.json { render json: @cryptos.pluck(:id, :name, :symbol, :price, :volume_24h) }
    end
  end
  
end
