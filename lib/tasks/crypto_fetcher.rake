namespace :crypto do
  desc "Fetch crypto prices and save them to the database"
  task fetch: :environment do
    require 'http'

    def fetch_crypto_data(symbols)
      base_url = 'https://api.binance.com/api/v3/ticker/24hr'
      symbols.map do |symbol|
        response = HTTP.get("#{base_url}?symbol=#{symbol}")
        JSON.parse(response.body.to_s) if response.status.success?
      end.compact
    end

    symbols = ['BTCUSDT', 'ETHUSDT']
    cryptos = fetch_crypto_data(symbols)

    cryptos.each do |crypto_data|
      Crypto.create_or_find_by(symbol: crypto_data['symbol']) do |crypto|
        crypto.name = crypto_data['symbol']
        crypto.price = crypto_data['lastPrice'].to_f
        crypto.volume_24h = crypto_data['volume'].to_i
        crypto.market_cap = crypto_data['quoteVolume'].to_i
        crypto.variation_24h = crypto_data['priceChangePercent'].to_f
      end
    end

    puts "Crypto data fetched and saved at #{Time.now}"
  end
end
