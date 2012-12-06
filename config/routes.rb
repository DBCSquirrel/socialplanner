Socialplanner::Application.routes.draw do
  root :to => 'events#new'

  resources :events

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
end
