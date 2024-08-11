Rails.application.routes.draw do
  scope "(:locale)", locale: /en|es/ do
    devise_for :users, controllers: { registrations: 'devise_session/registration' }

    get "up" => "rails/health#show", as: :rails_health_check

    # Defines the root path route ("/")
    root "home#index"

    resources :home
  end
end
