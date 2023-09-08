Rails.application.routes.draw do
  # Define Devise routes for user authentication
  devise_for :users

  devise_scope :user do 
    root "users#index"
    resources :users do
      delete 'posts/:id', to: 'posts#destroy', as: 'post_delete'

      resources :posts, only: [:index, :show, :new, :create] do
        member do
          post 'like'
          delete 'unlike'
        end
        resources :comments, only: [:create, :update, :destroy]
      end
    end
  end
end
