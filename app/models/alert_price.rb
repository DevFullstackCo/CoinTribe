class AlertPrice < ApplicationRecord
  belongs_to :user
  belongs_to :crypto

  validates :target_price, presence: true, numericality: { greater_than: 0 }
end
