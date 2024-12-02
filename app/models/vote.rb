class Vote < ApplicationRecord
  belongs_to :crypto
  belongs_to :user
end
