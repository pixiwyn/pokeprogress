Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :v1 do
    resources :pokedex, only: [ :index ]
    resources :games, only: [ :index ]
    resources :notes, only: [ :create ]
    get "notes/:pokemon_id", to: "notes#show"
    resources :progress, only: [:create]
    get "progress", to: "progress#show"
    namespace :auth do
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"
      delete "logout", to: "auth#logout"
    end
  end
end
