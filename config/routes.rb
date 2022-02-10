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

  # update user information
  patch '/users/:id/update', to: 'users#update', as: :user_update

  # posts
  resources :users do
    resources :posts
  end

  # search post
  get '/posts/search', to: 'posts#search', as: :search_posts
end
