Gingerr::Engine.routes.draw do
  root 'application#dashboard'
  resources :apps, only: [:show]
end
