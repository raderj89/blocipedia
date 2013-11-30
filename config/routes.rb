Blocipedia::Application.routes.draw do
  get "wikis/create"

  get "wikis/show"

  get "wikis/update"

  get "wikis/edit"

  get "wikis/destroy"

  devise_for :users

  resources :users, only: [:show, :index]
  resources :wikis

  resources :wiki_collaborations

  root to: 'pages#home'

  match "about" => 'pages#about'


end
