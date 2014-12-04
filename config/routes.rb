Rails.application.routes.draw do
  
  devise_for :users

  resources :pipeline, only: [:index, :new, :create]
  resources :backlog, only: [:index, :new, :create]

  resources :projects, only: [:update]

  root "pipeline#index"

end
