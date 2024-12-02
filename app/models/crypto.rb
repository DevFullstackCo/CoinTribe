class Crypto < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  has_many :posts
end
