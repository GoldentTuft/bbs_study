Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  # root 'static_pages#home'
  root 'bbs_threads#index'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/signup', to: 'users#create'
  resources :users do
      member do
        get :following, :followers
      end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  resources :bbs_threads, only: [:index, :create, :show, :destroy ]
  resources :user_posts, only: [:create, :destroy]
  resources :anonymous_posts, only: [:create, :destroy, :edit]
  resources :watches, only: [:create, :destroy]
end
