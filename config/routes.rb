Rails.application.routes.draw do
  resources :subcategories
  resources :categories 
  resources :addresses
  resources :coupons
 
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

  resources :cart_items, only: [:create, :update, :show] do
    get 'new_show', on: :collection
    post 'increment_quantity', on: :member
    post 'decrement_quantity', on: :member
    delete '', to: 'cart_items#destroy', on: :member
  end

  post '/add_to_cart', to: 'product_list#add_to_cart', as: 'add_to_cart'
  get '/apply_coupon', to: 'cart#apply_coupon'

  resources :products do
  end

  resources :wishlists, only: [:index, :create] do
    member do
      delete 'remove', to: 'wishlists#destroy', as: 'remove'
    end
  end

  get '/product_list', to: 'product_list#index'
  get '/product_list/mens', to: 'product_list#mens'
  get '/product_list/womens', to: 'product_list#womens'
  get '/product_list/show/:id', to: 'product_list#show', as: 'product_list_show'

   get 'load_subcategories/:id', to: 'products#load_subcategories'
  resources :cart_items, only: [:destroy]
  get '/checkout', to: 'checkout#index', as: 'checkout_index'
  post '/create_order_checkout', to: 'checkout#create_order', as: 'create_order_checkout'
  get '/order_success', to: 'checkout#order_success', as: 'order_success'
  post 'razorpay_payment_success', to: 'checkout#razorpay_payment_success'

  root 'welcome#index'
  get 'user_list', to: 'admin#user_list'

  resources :orders do
    put 'change_status', on: :member
    get 'generate_invoice', on: :collection
    post 'return_items/:item_id', action: :return_items, as: :return_items
    get 'show_user_side', on: :collection
  end

  get '/dashboard', to: 'dashboards#index', as: 'dashboard'

end
#git conflict solved