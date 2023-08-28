Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :new, :create, :show, :update] do
    resources :posts, only: [:index, :new, :create, :show, :update]
  end
end
