Socialplanner::Application.routes.draw do
  root :to => 'events#index'

  resources :events
  resources :users, :only => [:new]

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'register', to: 'sessions#new', as: 'register'
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'settings', to: 'users#edit', as: 'settings'
  match 'delete_account', to: 'users#destroy', as: 'delete_account'
end
