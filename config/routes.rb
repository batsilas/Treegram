Rails.application.routes.draw do
  get '/' => 'home#index'
  resources :users do
    resources :photos
    member do
      get :following, :followers
    end
  end
  resources :comments, only: [:create, :destroy]
  resources :tags, only: [:create, :destroy]
  get '/log-in' => "sessions#new"
  post '/log-in' => "sessions#create"
  get '/log-out' => "sessions#destroy", as: :log_out
  resources :follows, only: [:create, :destroy]
  resources :photos, only: [:destroy]
end
