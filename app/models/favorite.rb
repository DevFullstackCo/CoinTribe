class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :crypto

  validates :crypto_id, uniqueness: { scope: :user_id }

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    quantity * crypto.price
  end
end
