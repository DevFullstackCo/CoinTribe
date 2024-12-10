class ChangeQuantityToFloatInFavorites < ActiveRecord::Migration[8.0]
  def change
    change_column :favorites, :quantity, :float, using: 'quantity::float'
  end
  
end
