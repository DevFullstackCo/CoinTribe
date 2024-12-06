class AddLogoUrlToCryptos < ActiveRecord::Migration[8.0]
  def change
    add_column :cryptos, :logo_url, :string
  end
end
