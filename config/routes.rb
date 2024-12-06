Rails.application.routes.draw do

  resources :cryptos, only: [:index, :show, :create] do
    resources :posts, only: [:create]
    resources :votes, only: [:create]
  end

  resources :posts, only: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :profile do
    resources :avatars, only: [:create]
    
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check
  get 'cgu', to: 'static_pages#cgu'
  get "privacy_policy", to: "static_pages#privacy_policy"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "cryptos#index"
  
end
