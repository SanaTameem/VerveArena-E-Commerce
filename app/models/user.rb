class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :username, presence: true, length: { minimum: 3, maximum: 100 }
  validates :role, presence: true, inclusion: { in: %w[admin user] }
  validates :address, presence: true

  after_create :create_user_cart

  def generate_reset_password_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_sent_at = Time.now.utc
  end

  def admin?
    role == 'admin'
  end

  private

  def create_user_cart
    Cart.create(user: self)
  end
end
