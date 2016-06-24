Rails.application.routes.draw do
  get 'users' => "users#index"

  devise_for :users
  get 'home/index'
  root :to => 'home#index'
  mount API => '/'

  post 'api/v1/accounts/create'         => 'home#create'
  post 'api/v1/accounts/destroy'        => 'home#destroy'

  post 'api/v1/accounts/sign_in'        => 'home#create_session'
  post 'api/v1/accounts/social_sign_in' => 'home#social_sign_in'

  post 'api/v1/accounts/sign_out'       => 'home#delete_session'
  post 'api/v1/accounts/create_account' => 'home#create_account'
end
