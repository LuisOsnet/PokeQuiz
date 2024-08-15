module Api
  class ResultsController < Api::ApplicationController
    def index
      @users = fetch_users_with_games
      render :index, status: :ok
    rescue StandardError => e
      handle_error(e)
    end

    private

    def fetch_users_with_games
      User.includes(:games).where.not(games: { id: nil })
    end

    def handle_error(exception)
      error(:bad_request, exception.message)
    end
  end
end
