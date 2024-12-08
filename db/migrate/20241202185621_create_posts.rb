class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :crypto, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end
