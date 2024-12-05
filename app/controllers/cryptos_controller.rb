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
      format.json { render json: @cryptos.pluck(:id, :name, :symbol, :price, :variation_24h, :logo_url) }
    end
  end

  def show
    @crypto = Crypto.find(params[:id])
    @posts = @crypto.posts.order(created_at: :desc)
    @post = Post.new
    @comment = Comment.new
  end

  def create
    require 'http'

    symbols = ['bitcoin', 'ethereum', 'binancecoin', 'chainlink', 'dogecoin']
    def fetch_crypto_data(symbols)
      base_url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
      api_key = ENV['COINMARKETCAP_API_KEY']
    
      parameters = {
        'convert' => 'USD',
        'limit' => 10,
      }
    
      headers = {
        'X-CMC_PRO_API_KEY' => api_key,
        'Accept' => 'application/json',
      }
    
      response = HTTP.headers(headers).get(base_url, params: parameters)
    
      if response.status.success?
        data = JSON.parse(response.body.to_s)
    
        if data['status'] && data['status']['error_code'] == 0 && data['data']
          data['data'].map do |crypto|
            {
              name: crypto['name'],
              symbol: crypto['symbol'],
              price: crypto['quote']['USD']['price'],
              volume_24h: crypto['quote']['USD']['volume_24h'],
              variation_24h: crypto['quote']['USD']['percent_change_24h'],
            }
          end
        else
          nil
        end
      else
        nil
      end
    end

    cryptos = fetch_crypto_data(symbols)

    cryptos.each do |crypto_data|
      symbol_crypto = crypto_data[:symbol].downcase
      logo_url = "/#{symbol_crypto}.png"

      crypto = Crypto.find_or_initialize_by(symbol: symbol_crypto.upcase)

      new_data = {
        name: crypto_data[:name],
        price: crypto_data[:price].to_f,
        symbol: symbol_crypto.upcase,
        volume_24h: crypto_data[:volume_24h].to_f.to_i,
        variation_24h: crypto_data[:variation_24h].to_f,
        logo_url: logo_url
      }

      if crypto.update(new_data)
      else
        puts "Failed to update #{crypto.symbol}: #{crypto.errors.full_messages.join(', ')}"
      end
    end
  end
end
