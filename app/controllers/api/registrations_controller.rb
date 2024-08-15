# frozen_string_literal: true

module Api
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :authenticate_user!

    def create
      build_resource(sign_up_params)
      render json: {user: user_response_attributes(resource)}, status: :created if resource.save!
    rescue ActiveRecord::RecordInvalid => e
      error(:bad_request, e.record.errors.full_messages.to_sentence)
    rescue => e
      error(:bad_request, e&.message)
    end

    def sign_up_params
      params.require(:user).permit(
        :username,
        :email,
        :password
      )
    end

    def user_response_attributes(user)
      user.as_json(only: [:username, :email])
    end
  end
end
