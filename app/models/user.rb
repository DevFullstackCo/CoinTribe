class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :confirmable
  
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :cryptos, through: :votes
  has_many :votes_histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  has_many :favorites, dependent: :destroy
  has_many :favorite_cryptos, through: :favorites, source: :crypto # this relationship represents the cryptos that the user has marked as favorites
  
  before_create :generate_random_username
  before_create :set_accepted_at
  after_create :welcome_send
  after_destroy :send_account_deleted_email

  validates :accepted_cgu, inclusion: { in: [true], message: "Please accept the Terms of Service to continue." }, on: :create
  validates :accepted_privacy_policy, inclusion: { in: [true], message: "Please accept the Privacy Policy to continue." }, on: :create
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  private

  def set_accepted_at
    self.accepted_at = Time.current if accepted_cgu && accepted_privacy_policy
  end

  def generate_random_username
    loop do
      self.username = "@trader_#{rand(1000..999999)}"
      break unless self.class.exists?(username: username)
    end
  end

  def password_required?
    new_record? || password.present?
  end

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def send_account_deleted_email
    UserMailer.account_deleted_email(self).deliver_now
  end
end
