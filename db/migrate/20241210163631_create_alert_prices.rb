class CreateAlertPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :alert_prices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :crypto, null: false, foreign_key: true
      t.float :alert_price, null: false

      t.timestamps
    end
  end
end

