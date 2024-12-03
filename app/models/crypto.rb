class Crypto < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
<<<<<<< HEAD
  has_many :posts

  include PgSearch::Model

  pg_search_scope :search_by_name_or_symbol,
    against: [:name, :symbol],
    using: {
      tsearch: { prefix: true }
    }
=======
  has_many :posts, dependent: :destroy

  validates :name, :symbol, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

>>>>>>> dev
end
