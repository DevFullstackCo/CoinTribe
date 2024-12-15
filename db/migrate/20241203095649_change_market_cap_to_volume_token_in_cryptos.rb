class ChangeMarketCapToVolumeTokenInCryptos < ActiveRecord::Migration[8.0]
  def change
    remove_column :cryptos, :market_cap, :bigint
    add_column :cryptos, :volume_token_24h, :bigint
  end
end

