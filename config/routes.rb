Rails.application.routes.draw do
  get "decks/index"
  get "decks/show"
  get "decks/new"
  get "decks/edit"
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  devise_for :users, controllers: { registrations: "users/registrations" }

  get "/dashboard", to: "pages#dashboard"
  get "/profile", to: "pages#profile"

  resources :flashcards
  resources :user_conversations, only: [:index, :new, :create, :show, :destroy] do
    resources :user_conversation_messages, only: [:new, :create]
    member do
      get :call_assistant
    end
  end

  resources :chats, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
  end
  resources :saved_items, only: [:index]
  resources :words, only: [:show]
  resources :phrases, only: [:show]

  resources :decks do
   resources :flashcards, only: [:index]
  end
end
