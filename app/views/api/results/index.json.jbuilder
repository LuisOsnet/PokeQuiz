# frozen_string_literal: true

json.data do
  json.array! @users do |user|
    json.id user.id
    json.username user.username
    json.games do
      json.array! user.games do |game|
        json.id game.id
        json.score game.score
        json.finished game.finished
        json.quizzes do
          json.array! game.quizzes do |quiz|
            json.id quiz.id
            json.question quiz.question
            json.correct_answer quiz.correct_answer
            json.user_answer quiz.user_answer
          end
        end
      end
    end
  end
end
