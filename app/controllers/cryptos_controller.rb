class CryptosController < ApplicationController
    def index
        @crypto_search = Crypto.all 



    end



end
