namespace :crypto do
  desc "Fetch crypto prices Binance to BDD Crypto"
  task fetch: :environment do
    require 'http'

    symbols = ['BTCUSDT', 'ETHUSDT']

    def fetch_crypto_data(symbols)
      base_url = 'https://api.binance.com/api/v3/ticker/24hr'
      symbols.map do |symbol|
        response = HTTP.get("#{base_url}?symbol=#{symbol}")
        JSON.parse(response.body.to_s) if response.status.success?
      end
    end

    cryptos = fetch_crypto_data(symbols)

    cryptos.each do |crypto_data|
      crypto = Crypto.find_or_initialize_by(symbol: crypto_data['symbol'])

      new_data = {
        name: crypto_data['symbol'],
        price: crypto_data['lastPrice'].to_f,
        volume_24h: crypto_data['quoteVolume'].to_f.to_i,
        volume_token_24h: crypto_data['Volume'].to_i,
        variation_24h: crypto_data['priceChangePercent'].to_f
      }

      if crypto.update(new_data)
        puts "Crypto data updated for #{crypto.name} at #{Time.now}"
      else
        puts "No update needed for #{crypto.name} at #{Time.now}"
      end
    end
  end
end
