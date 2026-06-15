Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  authenticate :user, ->(user) { user.admin? } do
    mount MissionControl::Jobs::Engine, at: "/jobs"
  end
  
  root to: "pages#home"
  devise_for :users, controllers: { registrations: "users/registrations" }

  get "/dashboard", to: "pages#dashboard"
  get "/profile", to: "pages#profile"

  resources :flashcards
  resources :user_conversations, only: [:index, :new, :create, :show, :destroy] do
    resources :user_conversation_messages, only: [:new, :create]
    member do
      get  :call_assistant
      get  :call_typing_assistant
    end
  end

  resources :chats, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
  end
  resources :saved_items, only: [:index]
  resources :words, only: [:show]
  resources :phrases, only: [:show]
end
