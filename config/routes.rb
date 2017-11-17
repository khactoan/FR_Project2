Rails.application.routes.draw do
  root "posts#index"
  resources :posts
  devise_for :users

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
