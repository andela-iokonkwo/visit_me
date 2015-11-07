Rails.application.routes.draw do

  root "sessions#index"

  resources :meetings

  get "meetings/google/event" => "meetings#create_google_event", as: "google_event"

  get "/auth/:provider/callback", to: "sessions#create"

  get "logout" => "sessions#destroy"

end
