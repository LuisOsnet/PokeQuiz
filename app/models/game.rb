class Game < ApplicationRecord
  belongs_to :user
  has_many :quizzes, dependent: :destroy

  validates :user_id, presence: true
end
