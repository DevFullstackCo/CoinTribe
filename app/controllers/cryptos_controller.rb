class CryptosController < ApplicationController
    def index
       @cryptos = Crypto.all
    end

    def show
      @crypto = Crypto.find(params[:id])
    end

    
end
