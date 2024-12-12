class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, presence: true

  before_save :filter_profanity

  private

    def filter_profanity
      self.content = $profanity_filter.sanitize(content)
    end
end
