class Crypto < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_many :posts

  include PgSearch::Model

  pg_search_scope :search_by_name_or_symbol,
    against: [:name, :symbol],
    using: {
      tsearch: { prefix: true }
    }
end
