Rails.application.routes.draw do
  # admin user
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # auth users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # root
  root 'posts#index'

  # redirects
  get '/users' => redirect('/users/sign_up')

  # current user mypage
  get '/users/:id/mypage', to: 'users#mypage', as: :user_mypage

  # user information edit form
  get '/users/:id/edit', to: 'users#edit', as: :user_edit

  # user all posts
  get '/users/:id/all_posts', to: 'users#get_all_posts', as: :user_all_posts

  # user all likes
  get '/users/:id/all_likes', to: 'users#get_all_likes', as: :user_all_likes

  # update user information
  patch '/users/:id/update', to: 'users#update', as: :user_update

  # posts
  resources :users do
    resources :posts
  end

  # search post
  get '/posts/search', to: 'posts#search', as: :search_posts

  # comments
  resources :users do
    resources :posts do
      resources :comments, only: %i(create destroy)
    end
  end

  # likes(api)
  namespace :api, format: 'json' do
    namespace :v1 do
      get '/user', to: 'likes#get_current_user_id'
      get '/posts/:id/all_likes', to: 'likes#get_all_likes'
      post '/users/:user_id/posts/:post_id/like_post', to: 'likes#like_post'
      delete '/users/:user_id/posts/:post_id/unlike_post', to: 'likes#unlike_post'
      get '/users/:user_id/posts/:post_id/check', to: 'likes#check_like'
    end
  end

end
