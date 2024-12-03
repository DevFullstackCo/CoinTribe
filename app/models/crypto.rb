class Crypto < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  has_many :posts, dependent: :destroy

  validates :name, :symbol, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

end
