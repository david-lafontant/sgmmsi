Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations] 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :stations
  resources :station_types
  resources :vessels
  resources :mmsis, only: [:edit, :update]
  get '/dashboard', to: "pages#dashboard", as: :dashboard
  # get 'callsigns', to: "callsigns#index", as: :callsigns
  get 'unapproved_stations', to: "pages#unapproved_stations", as: :unapproved_stations
  get 'unapproved_vessels', to: "pages#unapproved_vessels", as: :unapproved_vessels
  root "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # 

end
