namespace :crypto do
  desc "Fetch crypto prices Binance to BDD Crypto"
  task fetch: :environment do
    require 'http'

    def fetch_crypto_data
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

      begin
        response = HTTP.headers(headers).get(base_url, params: parameters)

        if response.status.success?
          data = JSON.parse(response.body.to_s)

          if data['status'] && data['status']['error_code'] == 0 && data['data']
            return data['data'].map do |crypto|
              {
                name: crypto['name'],
                symbol: crypto['symbol'],
                price: crypto['quote']['USD']['price'],
                volume_24h: crypto['quote']['USD']['volume_24h'],
                variation_24h: crypto['quote']['USD']['percent_change_24h'],
              }
            end
          else
            puts "API returned no valid data or there was an error with the request."
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

    cryptos = fetch_crypto_data

    if cryptos.empty?
      puts "No crypto data available to update."
    else
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
          puts "Updated #{crypto.symbol} successfully."
        else
          puts "Failed to update #{crypto.symbol}: #{crypto.errors.full_messages.join(', ')}"
        end
      end
    end
  end
end
