class AddPriceUpAndPriceDownToAlertPrices < ActiveRecord::Migration[8.0]
  def change
    add_column :alert_prices, :price_up, :float
    add_column :alert_prices, :price_down, :float
    remove_column :alert_prices, :target_price, :float 
  end
end
