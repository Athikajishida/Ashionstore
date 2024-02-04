Rails.application.routes.draw do
  resources :products
  resources :categories 


  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
devise_for :users, skip: [:sessions]
as :user do
  get 'signin', to: 'devise/sessions#new', as: :new_user_session
  post 'signin', to: 'devise/sessions#create', as: :user_session
  match 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
end

  resources :admin, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch 'toggle_user'

      get 'show_user' 
    end
    collection do
      get 'manage_users'
    end
  end

  root 'welcome#index'
end
