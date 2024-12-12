class AlertPrice < ApplicationRecord
  belongs_to :user
  belongs_to :crypto

  validates :price_up, numericality: { allow_nil: true }
  validates :price_down, numericality: { allow_nil: true }
end
