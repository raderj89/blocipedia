Blocipedia::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :index]

  root to: 'pages#home'

  match "about" => 'pages#about'


end
