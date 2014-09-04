TttTestApp::Application.routes.draw do
  
  root to: 'sessions#new'
  resources :games
  resources :users
  resources :sessions
  resources :moves

  get 'logout', to: 'sessions#destroy', as: 'logout'
  post '/games/:id/make_move/:position', to: 'games#make_move', as: 'make_move'
  
end
