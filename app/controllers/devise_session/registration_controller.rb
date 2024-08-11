class DeviseSession::RegistrationController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(
      :username,
      :email,
      :password
    )
  end
end
