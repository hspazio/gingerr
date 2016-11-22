Gingerr::Engine.routes.draw do
  root 'application#dashboard'
  resources :apps, only: [:show] do
    resources :signals, only: [:show], shallow: true
  end
end
