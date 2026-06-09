Rails.application.routes.draw do
  # get "user_conversations/new"
  # get "user_conversations/create"
  # get "user_conversations/show"
  # get "user_conversations/destroy"
  # get "user_conversation_messages/create"
  resources :user_conversations, only: [:new, :create, :show, :destroy]
  resources :user_conversation_messages, only: [:create]
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  resources :chats, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
  end
end
