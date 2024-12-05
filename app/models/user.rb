class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :cryptos, through: :votes
  has_many :votes_histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  
  after_create :welcome_send
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  

  after_create :welcome_send
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  

  validates :accepted_cgu, inclusion: { in: [true], message: "Please accept the Terms of Service to continue." }, on: :create
  validates :accepted_privacy_policy, inclusion: { in: [true], message: "Please accept the Privacy Policy to continue." }, on: :create
  before_create :set_accepted_at

  validates :password, presence: true, length: { minimum: 8 }, format: {
    with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&+=!]).{8,}\z/,
    message: "It must contain at least 8 characters, one uppercase letter, one lowercase letter, one digit, and one special character (@#$%^&+=!)"
  }
  validates :email, presence: true, format: {
    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/,
    message: "It must be a valid email address."
  }
  private
  def set_accepted_at
    self.accepted_at = Time.current if accepted_cgu && accepted_privacy_policy
  end
end
