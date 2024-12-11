class RenameAlertPriceToTargetPriceInAlertPrices < ActiveRecord::Migration[8.0]
  def change
    rename_column :alert_prices, :alert_price, :target_price
  end
end
