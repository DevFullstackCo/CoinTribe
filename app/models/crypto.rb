class Crypto < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  has_many :posts

  include PgSearch::Model

  pg_search_scope :search_by_name_or_symbol,
    against: [:name, :symbol],
    using: {
      tsearch: { prefix: true }
    }
  has_many :posts, dependent: :destroy

  validates :name, :symbol, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def bullish_percentage
    total_votes = votes.count
    return 0 if total_votes.zero?
    (votes.where(is_bullished: true).count.to_f / total_votes * 100).round(1)
  end

  def bearish_percentage
    total_votes = votes.count
    return 0 if total_votes.zero?
    100 -  bullish_percentage
  end


end
