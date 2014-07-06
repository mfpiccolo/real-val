Rails.application.routes.draw do
  devise_for :users
  root :to => "visitors#index"

  resources :properties
  resources :zip_codes
  resources :users, only: [:edit, :update]
end
