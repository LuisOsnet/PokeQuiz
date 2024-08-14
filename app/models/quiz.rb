class Quiz < ApplicationRecord
  belongs_to :game

  validates :game_id, presence: true
end
