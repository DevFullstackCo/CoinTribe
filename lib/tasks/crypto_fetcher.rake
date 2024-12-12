namespace :crypto do
  desc "Fetch crypto prices Binance to BDD Crypto"
  task fetch: :environment do
    require 'http'

    def fetch_crypto_data(symbols)
      base_url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest'
      api_key = ENV['COINMARKETCAP_API_KEY']

      symbols_param = symbols.join(',')

      parameters = {
        'convert' => 'USD',
        'symbol' => symbols_param, 
      }

      headers = {
        'X-CMC_PRO_API_KEY' => api_key,
        'Accept' => 'application/json',
      }

      begin
        response = HTTP.headers(headers).get(base_url, params: parameters)

        if response.status.success?
          data = JSON.parse(response.body.to_s)
          if data['status'] && data['status']['error_code'] == 0 && data['data']
            return data['data'].values.map do |crypto|
              {
                name: crypto['name'],
                symbol: crypto['symbol'],
                price: crypto['quote']['USD']['price'],
                volume_24h: crypto['quote']['USD']['volume_24h'],
                variation_24h: crypto['quote']['USD']['percent_change_24h'],
              }
            end
          else
            puts "No valid data returned for the requested symbols."
            return []
          end
        else
          puts "API request failed with status #{response.status}"
          return []
        end
      rescue SocketError => e
        puts "Network error: #{e.message}"
        return []
      rescue StandardError => e
        puts "An error occurred: #{e.message}"
        return []
      end
    end

    crypto_list = ['BTC', 'ETH', 'XRP', 'ADA', 'BNB', 'DOGE', 'SOL', 'TRX', 'USDC']
    cryptos = fetch_crypto_data(crypto_list)

    if cryptos.empty?
      puts "No crypto data available to update."
    else
      cryptos.each do |crypto_data|
        symbol_crypto = crypto_data[:symbol].downcase
        logo_url = "/#{symbol_crypto}.png"
        price_crypto = crypto_data[:price]
        alerts = AlertPrice.joins(:crypto).where(crypto: { symbol: symbol_crypto.upcase })

        alerts.each do |alert|
          if alert.price_up && price_crypto >= alert.price_up && alert.price_up > 0
            Notification.create(
              user: alert.user,
              title: "Price Up Alert: #{crypto_data[:name]}",
              content: "The price of #{crypto_data[:name]} has risen to $#{price_crypto}.",
              is_read?: false
            )
          end

          if alert.price_down && price_crypto <= alert.price_down && alert.price_down > 0
            Notification.create(
              user: alert.user,
              title: "Price Down Alert: #{crypto_data[:name]}",
              content: "The price of #{crypto_data[:name]} has fallen to $#{price_crypto}.",
              is_read?: false
            )
          end
        end

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
          puts "Updated #{crypto.symbol} successfully."
        else
          puts "Failed to update #{crypto.symbol}: #{crypto.errors.full_messages.join(', ')}"
        end
      end
    end
  end
end
