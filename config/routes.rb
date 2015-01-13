Rails.application.routes.draw do
  
  devise_for :users

  resources :pipeline, only: [:index, :new, :create]
  resources :backlog, only: [:index, :new, :create]

  resources :projects, only: [:update]
  resources :project_backlog_months, only: [:update]

  sidekiq_constraint = lambda do |request|
    request.env['warden'].authenticate?
  end

  constraints sidekiq_constraint do
    mount Sidekiq::Web, :at => "/sidekiq"
  end

  root "pipeline#index"

end
