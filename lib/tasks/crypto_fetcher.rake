namespace :crypto do
  desc "Fetch crypto prices Binance to BDD Crypto"
  task fetch: :environment do
    require 'http'

    symbols = ['BTCUSDT', 'ETHUSDT', 'BNBUSDT', 'LINKUSDT', 'DOGEUSDT', 'PEPEUSDT']

    def fetch_crypto_data(symbols)
      base_url = 'https://api.binance.com/api/v3/ticker/24hr'
      symbols.map do |symbol|
        response = HTTP.get("#{base_url}?symbol=#{symbol}")
        JSON.parse(response.body.to_s) if response.status.success?
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
        puts "No update needed for #{crypto.name} at #{Time.now}"
      end
    end
  end
end
