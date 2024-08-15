module Api
  class AuthenticationController < Devise::SessionsController
    include ActionController::Flash
    skip_before_action :authenticate_user!
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if resource.persisted?
        render json: {
          user: {
            id: resource.id,
            jti: resource.jti
          }
        }, status: :ok
      else
        unauthenticated
      end
    end

    def unauthenticated
      error(:unauthorized)
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
