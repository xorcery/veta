require 'sidekiq/web'

Rails.application.routes.draw do
  
  devise_for :users, :skip => [:registrations]                                          
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
    end

  resources :pipeline, only: [:index, :new, :create]
  resources :backlog, only: [:index, :new, :create]

  resources :projects, only: [:update] do 
    resources :changelogs, only: [:index]
  end
  resources :project_backlog_months, only: [:update]

  resources :projections, only: [:index]

  sidekiq_constraint = lambda do |request|
    request.env['warden'].authenticate?
  end

  constraints sidekiq_constraint do
    mount Sidekiq::Web, :at => "/sidekiq"
  end

  root "pipeline#index"

end
