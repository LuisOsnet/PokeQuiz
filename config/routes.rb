Rails.application.routes.draw do
  get 'quizzes/index'
  root to: "home#index", as: :root_with_locale

  scope "(:locale)", locale: /en|es/ do
    devise_for :users, controllers: { registrations: "devise_session/registration" }

    get "up" => "rails/health#show", as: :rails_health_check

    # Root path with locale
    # root to: "games#index", as: :root_with_locale

    resources :home
    resources :games do
      resources :quizzes
    end
  end

  # Catch-all route to redirect to the locale root if the locale is missing
  get '', to: redirect("/%{locale}", status: 302), defaults: { locale: I18n.default_locale }
end
