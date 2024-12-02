class CreateVotesHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :votes_histories do |t|
      t.references :crypto, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_bullished
      t.date :voted_at
      t.timestamps
    end
  end
end
