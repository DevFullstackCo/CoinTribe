class AlertPrice < ApplicationRecord
  belongs_to :user
  belongs_to :crypto

  validates :alert_price, presence: true, numericality: { greater_than: 0 }
end
