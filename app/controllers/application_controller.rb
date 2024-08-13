class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  def after_sign_in_path_for(resource)
    games_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
