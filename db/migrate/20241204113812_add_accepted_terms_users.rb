class AddAcceptedTermsUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :accepted_cgu, :boolean, default: false, null: false
    add_column :users, :accepted_privacy_policy, :boolean, default: false, null: false
    add_column :users, :accepted_at, :datetime
  end
end

