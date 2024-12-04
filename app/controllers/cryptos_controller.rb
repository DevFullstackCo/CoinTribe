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
    @posts = @crypto.posts.order(created_at: :desc)
    @post = Post.new
    @post.crypto = @crypto
  end

  def create 
    require 'http'
  
    symbols = ['BTCUSDT', 'ETHUSDT', 'BNBUSDT', 'LINKUSDT', 'DOGEUSDT', 'PEPEUSDT']
  
    def fetch_crypto_data(symbols)
      base_url = 'https://api.binance.com/api/v3/ticker/24hr'
      symbols.map do |symbol|
        response = HTTP.get("#{base_url}?symbol=#{symbol}")
        if response.status.success?
          JSON.parse(response.body.to_s)
        else
          puts "Error fetching data for #{symbol}: #{response.status}"
          nil
        end
      end.compact
    end
  
    cryptos = fetch_crypto_data(symbols)
  
    symbol_to_name = {
      'BTC' => 'Bitcoin',
      'ETH' => 'Ethereum',
      'BNB' => 'Binance Coin',
      'LINK' => 'ChainLink',
      'DOGE' => 'DogeCoin',
      'PEPE' => 'PepeCoin'
    }
  
    cryptos.each do |crypto_data|
      symbol_crypto = crypto_data['symbol'][0..-5]
      crypto = Crypto.find_or_initialize_by(symbol: symbol_crypto)
      name = symbol_to_name[symbol_crypto]
  
      new_data = {
        name: name,
        price: crypto_data['lastPrice'].to_f,
        symbol: symbol_crypto,
        volume_24h: crypto_data['quoteVolume'].to_f.to_i,
        volume_token_24h: crypto_data['volume'].to_f.to_i,
        variation_24h: crypto_data['priceChangePercent'].to_f
      }
  
      if crypto.update(new_data)
        puts "Crypto data updated for #{crypto.name} at #{Time.now}"
      else
        puts "Failed to update #{crypto.symbol}: #{crypto.errors.full_messages.join(', ')}"
      end
    end
  end
  

    
end
