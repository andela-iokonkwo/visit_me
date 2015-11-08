Rails.application.routes.draw do
  root "pages#index"

  get "receptionists/show"

  get "receptionists/index"

  get "receptionists/create"

  get "receptionists/delete"

  get "receptionists/update"

  get "receptionists/edit"


  resources :meetings

  get "meetings/google/event" => "meetings#create_google_event", as: "google_event"

  get "/auth/:provider/callback", to: "sessions#create"

  get "logout" => "sessions#destroy"
end
