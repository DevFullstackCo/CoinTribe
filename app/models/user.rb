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
  

  validates :accepted_cgu, inclusion: { in: [true], message: "Veuillez accepter les CGU pour continuer." }, on: :create
  validates :accepted_privacy_policy, inclusion: { in: [true], message: "Veuillez accepter la politique de confidentialité pour continuer." }, on: :create
  before_create :set_accepted_at

  private
  def set_accepted_at
    self.accepted_at = Time.current if accepted_cgu && accepted_privacy_policy
  end
end
