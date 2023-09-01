Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :posts do
      resources :comments, only: [:create, :update, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
end
