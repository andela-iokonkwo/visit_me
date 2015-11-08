Rails.application.routes.draw do
  root "pages#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'receptionists/show'

  get 'receptionists/index'

  get 'receptionists/create'

  get 'receptionists/delete'

  get 'receptionists/update'

  get 'receptionists/edit'

  resources :sessions

  resources :meetings
  post "/visitors", to: "visitors#create"
  get "meetings/google/event" => "meetings#create_google_event", as: "google_event"

  get "/auth/:provider/callback", to: "sessions#create"

  get "logout" => "sessions#destroy"

end
