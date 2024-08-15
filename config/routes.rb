Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get "up" => "rails/health#show", :as => :rails_health_check
  root to: "home#index", as: :root_with_locale

  namespace :api, defaults: {format: :json} do
    resources :results

    devise_scope :user do
      post "/signup", to: "registrations#create"
      post "/signin", to: "authentication#create"
      delete "/signout", to: "authentication#destroy"
    end
  end

  scope "(:locale)", locale: /en|es/ do
    devise_for :users, controllers: {registrations: "devise_session/registration"}

    resources :home, only: :index
    resources :games, only: [:index, :show, :create] do
      resources :quizzes, only: [:index, :create]
    end
  end

  get "", to: redirect("/%{locale}", status: 302), defaults: {locale: I18n.default_locale}
end
