Blocipedia::Application.routes.draw do

  get "subscriptions/new"

  get "subscriptions/create"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:index, :show] do
    resources :subscriptions
  end

  resources :wikis

  resources :wiki_collaborations

  root to: 'pages#home'

  match "about" => 'pages#about'


end
