Rails.application.routes.draw do
  resources :subcategories

  resources :categories 
  resources :addresses


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

  resources :products do
  end

  get 'load_subcategories/:id', to: 'products#load_subcategories'

  root 'welcome#index'
  get 'user_list', to: 'admin#user_list'

end
