Rails.application.routes.draw do

  get 'notification/index'
  get 'entries/create'
  get 'entries/destroy'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }  
  root 'pages#home'
  get 'pages/index'
  get 'pages/show'
 
  get 'pages/followings/:id' => 'pages#followings', as: 'pages_followings'
  
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  resources :talks,only: [:show, :create] do 
      resources :entries, :messages, only: [:create, :destroy]
  end

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
