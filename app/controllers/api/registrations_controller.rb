# frozen_string_literal: true

module Api
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :authenticate_user!

    def create
      build_resource(sign_up_params)
      render json: resource, status: :created if resource.save!
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
  end
end
