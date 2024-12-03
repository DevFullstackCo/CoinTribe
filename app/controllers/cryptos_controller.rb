class CryptosController < ApplicationController
  def index
    if params[:search].present?
      # Filtrer les cryptos par nom (ou autre champ)
      @crypto_search = Crypto.where("name LIKE ?", "%#{params[:search]}%")
    else
      @crypto_search = Crypto.limit(5)
    end

    respond_to do |format|
      format.html  # Pour les requêtes classiques
      format.js    # Pour les requêtes AJAX
    end
  end



end
