class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :generate_random_username


  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :cryptos, through: :votes
  has_many :votes_histories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  has_many :favorites, dependent: :destroy
  has_many :favorite_cryptos, through: :favorites, source: :crypto # this relationship represents the cryptos that the user has marked as favorites
  
  after_create :welcome_send
  
  def welcome_send
    #UserMailer.welcome_email(self).deliver_later
  end
  
  validates :accepted_cgu, inclusion: { in: [true], message: "Please accept the Terms of Service to continue." }, on: :create
  validates :accepted_privacy_policy, inclusion: { in: [true], message: "Please accept the Privacy Policy to continue." }, on: :create
  before_create :set_accepted_at
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  
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
end
