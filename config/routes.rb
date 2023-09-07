Rails.application.routes.draw do
  # Define Devise routes for user authentication
  devise_for :users

  devise_scope :user do 
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
end

