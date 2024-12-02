class CreateCryptos < ActiveRecord::Migration[8.0]
  def change
    create_table :cryptos do |t|
      t.string :name
      t.float :price
      t.string :symbol
      t.integer :volume_24h
      t.integer :market_cap
      t.float :variation_24h
      t.timestamps
    end
  end
end
