Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :products, only: [:new, :index, :edit] do
    get '/config', to: 'service_definitions#product_config'
  end

  resources :checkouts, only: [:new, :index]
  resources :companies, only: [:new, :show, :edit]
  resources :orders, only: [:index, :show, :new]
  resources :clients, only: [:new, :index, :show, :edit]
  resources :admin, only: [:new, :index, :show, :edit]
  resources :service_definitions do
    resources :subscriptions
  end

  get '/saloon', to: 'saloon#index'
  get '/tables/new', to: 'saloon#new'
  get '/daily-report', to: 'companies#daily_report'

  namespace :api do
    namespace :v1 do
      resources :products do
        post :upload_images, on: :member
      end

      resources :companies
      resources :users, only: %i[index create]
      resources :clients, only: %i[index create update]
      resources :saloon, only: :index
      resources :orders, only: %i[create show update]
      resources :tables, only: %i[create update destroy show]
      resources :categories, only: :create
      resources :service_definitions, only: %i[create update show]

      post '/import-products', to: 'importations#products'
      post '/subscriptions', to: 'subscriptions#create'
      patch '/subscriptions/:id', to: 'subscriptions#update'

      get '/daily-report', to: 'reports#daily_report'

      get 'admin/clients', to: 'admin#clients'
      get 'admin/company/:id', to: 'admin#company'

    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
