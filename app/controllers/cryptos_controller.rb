class CryptosController < ApplicationController
    def index
        @cryptto_search = Crypto.all 


        
    end



end
