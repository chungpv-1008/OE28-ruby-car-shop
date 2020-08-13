class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex
  USER_PARAMS = %i(name email phone_number address password
    password_confirmation).freeze

  attr_accessor :remember_token

  has_many :posts, dependent: :destroy
  has_many :favorite_lists, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.user.name_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :address, presence: true, length: {maximum: Settings.user.address}
  validates :phone_number, presence: true, numericality: {only_integer: true},
    length: {maximum: Settings.user.phone_number}
  validates :password, presence: true,
    length: {minimum: Settings.user.password_length}, allow_nil: true

  before_save :downcase_email

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
