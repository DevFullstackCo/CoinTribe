class VotesHistory < ApplicationRecord
  belongs_to :crypto
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:crypto_id, :voted_at] }
end
