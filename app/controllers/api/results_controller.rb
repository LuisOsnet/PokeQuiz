module Api
  class ResultsController < ApplicationController
    def index
      @users = User.includes(:games)
      render :index, status: :ok
    rescue => e
      error(:bad_request, e&.message)
    end
  end
end
