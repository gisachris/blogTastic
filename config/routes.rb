Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :posts do
      member do
        post 'like'
        delete 'unlike'
      end
      resources :comments, only: [:create, :update, :destroy]
    end
  end
end
