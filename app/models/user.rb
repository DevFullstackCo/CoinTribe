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

  validates :accepted_cgu, inclusion: { in: [true], message: "Veuillez accepter les CGU pour continuer." }, on: :create
  validates :accepted_privacy_policy, inclusion: { in: [true], message: "Veuillez accepter la politique de confidentialité pour continuer." }, on: :create
  before_create :set_accepted_at

  validates :password, presence: true, length: { minimum: 8 }, format: {
    with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&+=!]).{8,}\z/,
    message: "doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial (@#$%^&+=!)"
  }
  private
  def set_accepted_at
    self.accepted_at = Time.current if accepted_cgu && accepted_privacy_policy
  end
end
