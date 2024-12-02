class Post < ApplicationRecord
  belongs_to :user
  belongs_to :crypto
  has_many :comments
end
