class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_create :generate_random_username
  validates :username, presence: true, uniqueness: true, format: { with: /\A@trader_\d{6}\z/, message: "must start with @trader_ followed by 5 digits" }


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
