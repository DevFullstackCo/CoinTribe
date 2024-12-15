class Post < ApplicationRecord
  belongs_to :user
  belongs_to :crypto
  has_many :comments, dependent: :destroy

  validates :content, presence: true

  before_save :filter_profanity

  private

  def filter_profanity
    self.content = $profanity_filter.sanitize(content)
  end

end

