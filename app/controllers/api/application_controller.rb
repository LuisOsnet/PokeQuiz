module Api
  class ApplicationController < ActionController::API
    before_action :authenticate_user!
    include ErrorsHandler

    def authenticate_user!
      return unauthenticated unless user_signed_in?

      current_user
    end

    private

    def unauthenticated
      error(:unauthorized)
    end
  end
end
