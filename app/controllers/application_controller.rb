class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  before_action :set_locale
  include Api::ErrorsHandler

  def after_sign_in_path_for(resource)
    games_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def unauthenticated
    error(:unauthorized)
  end
end
