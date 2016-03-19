Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'users/new'

  resources :users
end