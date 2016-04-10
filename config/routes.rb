Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  
  #1． ルーティングの定義
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users do
    member do
      get :bookmarks
    end
  end

end