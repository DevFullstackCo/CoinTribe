class CryptosController < ApplicationController
  def index
    create
    @new_cryptos = Crypto.order(created_at: :desc).limit(5)
    if params[:search].present?
      @cryptos = Crypto.search_by_name_or_symbol(params[:search])
    else
      @cryptos = Crypto.limit(5)
    end

    respond_to do |format|
      format.html 
      format.json { render json: @cryptos.pluck(:id, :name, :symbol, :price, :variation_24h) }
    end
  end

  def show
    @crypto = Crypto.find(params[:id])
    @posts = @crypto.posts.includes(:comments).order(created_at: :desc)
    @post = Post.new
    @comment = Comment.new
  end

  def create 
    require 'http'

    symbols = ['bitcoin', 'ethereum', 'binancecoin', 'chainlink', 'dogecoin', 'pepecoin'] 

    def fetch_crypto_data(symbols)
      base_url = 'https://api.coingecko.com/api/v3/coins/'

      # Requête API CoinGecko pour récupérer les informations de chaque crypto
      symbols.map do |symbol|
        response = HTTP.get("#{base_url}#{symbol}")
        if response.status.success?
          data = JSON.parse(response.body.to_s)
          {
            name: data['name'],
            symbol: data['symbol'],
            price: data['market_data']['current_price']['usd'],
            volume_24h: data['market_data']['total_volume']['usd'],
            variation_24h: data['market_data']['price_change_percentage_24h']
          }
        else
          puts "Error fetching data for #{symbol}: #{response.status}"
          nil
        end
      end.compact
    end

    cryptos = fetch_crypto_data(symbols)

    cryptos.each do |crypto_data|
      symbol_crypto = crypto_data[:symbol].upcase  # Assurez-vous que le symbole soit en majuscule, comme dans votre base de données
      crypto = Crypto.find_or_initialize_by(symbol: symbol_crypto)

      # Mise à jour des données de la crypto
      new_data = {
        name: crypto_data[:name],
        price: crypto_data[:price].to_f,
        symbol: symbol_crypto,
        volume_24h: crypto_data[:volume_24h].to_f.to_i,
        variation_24h: crypto_data[:variation_24h].to_f
      }

      if crypto.update(new_data)
        puts "Crypto data updated for #{crypto.name} at #{Time.now}"
      else
        puts "Failed to update #{crypto.symbol}: #{crypto.errors.full_messages.join(', ')}"
      end
    end
  end
end
