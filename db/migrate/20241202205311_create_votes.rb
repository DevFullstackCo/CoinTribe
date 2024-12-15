class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :crypto, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_bullished
      t.timestamps
    end
  end
end

