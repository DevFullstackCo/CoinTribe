Rails.application.routes.draw do

  resources :cryptos, only: [:index, :show, :create] do
    resources :posts, only: [:create]
    resources :votes, only: [:create]
    resources :favorites, only: [:create, :edit, :update]
    resources :alert_prices, only: [:create, :edit, :update, :destroy]
  end

  resources :posts, only: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]

  resources :notifications, only: [:create, :update, :destroy]
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :profile, only: [:show, :update] do
    resources :avatars, only: [:create]
    collection do
      get :search
    end
    member do
      delete :delete_user
    end
  end
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check
  get 'cgu', to: 'static_pages#cgu'
  get 'faq', to: 'static_pages#faq'
  get "privacy_policy", to: "static_pages#privacy_policy"
  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'
  post 'contact/send_message', to: 'static_pages#send_message'

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "cryptos#index"
  
end
