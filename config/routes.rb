Blocipedia::Application.routes.draw do

  as :user do
    get '/sign_up', to: 'users/registrations#new', as: :sign_up
    get '/sign_in', to: 'devise/sessions#new', as: :sign_in
    get '/:id/edit', to: 'users/registrations#edit', as: :edit
  end

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

  get '/:id', to: 'users#show', as: 'user', constraints: { id: /[\w+\.]+/ }

end
