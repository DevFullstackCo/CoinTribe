class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    create_table :favorites do |t|
      t.references :crypto, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :is_favorite, null: false, default: false
      t.integer :quantity, default: 0

      t.timestamps
    end

    add_index :favorites, [:user_id, :crypto_id], unique: true
  end
end
