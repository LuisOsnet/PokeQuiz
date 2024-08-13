class QuizzesController < ApplicationController
  def index
    @question = Quizzes::GenerateQuestionsService.new.call

    if @question.nil? || @question[:error]
      handle_error(@question&.dig(:error) || "Unknown error occurred")
    end
  rescue StandardError => e
    handle_error(e.message)
  end

  def create
    response = Quizzes::CreationService.new(
      params[:game_id],
      params[:user_answer],
      params[:correct_answer],
      params[:question]
    ).call

    if response
      redirect_to game_quizzes_path
    end
  end

  private

  def handle_error(error_message)
    Rails.logger.error("An error occurred in QuizzesController#index: #{error_message}")

    redirect_to '/500' and return
  end
end
