Rails.application.routes.draw do
  namespace :admin do
    resources :posts
  end

  devise_for :users
end
