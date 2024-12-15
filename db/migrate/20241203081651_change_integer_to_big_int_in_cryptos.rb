class ChangeIntegerToBigIntInCryptos < ActiveRecord::Migration[8.0]
  def change
    change_column :cryptos, :volume_24h, :bigint
    change_column :cryptos, :market_cap, :bigint
  end
end

