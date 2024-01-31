Rails.application.routes.draw do
  resources :products
  resources :categories
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :admin, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch 'block_user'
      patch 'unblock_user'
      get 'show_user' 
    end
    collection do
      get 'manage_users'
    end
  end

  root 'welcome#index'
end
