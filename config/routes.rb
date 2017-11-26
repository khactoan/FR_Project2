Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth"}
  get "tags/:tag", to: "posts#index", as: :tag

  resources :comments

  resources :posts do
    collection do
      get "interested/", to: "posts#interested", as: :interested
    end
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    resources :users
    resources :posts
  end
end
