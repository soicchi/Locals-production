Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, only: [:show, :destroy] do
        member do
          get :user_posts
        end
        collection do
          get :book_mark_posts, :liked_posts_ids, :disliked_posts_ids, :following_posts, :liked_posts
        end
      end
      resources :posts,           only: [:index, :show, :create, :destroy]
      resources :relationships,   only: [:create, :destroy]
      resources :book_marks,      only: [:create, :destroy]
      resources :likes,           only: [:create, :destroy]
      resources :dislikes,        only: [:create, :destroy]
      resources :categories,      only: [:index, :create, :destroy]
      resources :health_checks,   only: [:index]
      resources :guests,          only: [:create]
      resources :current_users,   only: [:index]
      get       '/search',        to: 'searches#search'
    end
  end
end
