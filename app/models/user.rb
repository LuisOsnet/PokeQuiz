class User < ApplicationRecord
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable

  has_many :games, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true

  validates :email, uniqueness: true

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  validates :password, length: {in: 6..128}
  validates :username, length: {minimum: 6, maximum: 10}
end
