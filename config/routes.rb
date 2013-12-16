Blocipedia::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  devise_scope :user do
    put 'users/update_plan', :to => 'users/registrations#update_plan'
    put 'users/cancel_plan', :to => 'users/registrations#cancel_plan'
  end

  resources :users, only: [:index, :show]

  resources :wikis

  resources :wiki_collaborations

  root to: 'pages#home'

  match "about" => 'pages#about'

  match '404', to: redirect('/')

end
