module Quizzes
  class CreationService
    attr_reader :game_id, :user_answer, :correct_answer, :question

    def initialize(game_id, user_answer, correct_answer, question)
      @game_id = game_id
      @user_answer = user_answer
      @correct_answer = correct_answer
      @question = question
    end

    def call
      ActiveRecord::Base.transaction do
        quiz = game.quizzes.new(
          user_answer: user_answer,
          correct_answer: correct_answer,
          question: question
        )

        quiz.points = 1 if user_answer == correct_answer

        if quiz.save
          return true
        else
          raise ActiveRecord::Rollback
        end
      end
    rescue StandardError => e
      Rails.logger.error("Failed to save quiz: #{e.message}")
      false
    end

    private

    def game
      @game = Game.find_by(id: game_id)
    end
  end
end