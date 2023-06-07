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

  get '/saloon', to: 'saloon#index'
  get '/tables/new', to: 'saloon#new'
  get '/daily-report', to: 'companies#daily_report'

  namespace :api do
    namespace :v1 do
      resources :products do
        post :upload_images, on: :member
      end

      resources :companies
      resources :users, only: [:index, :create]
      resources :clients, only: [:index, :create, :update]
      resources :saloon, only: :index
      resources :orders, only: [:create, :show, :update]
      resources :tables, only: [:create, :update, :destroy, :show]
      resources :categories, only: :create

      post '/import-products', to: 'importations#products'
      get '/daily-report', to: 'reports#daily_report'

      get 'admin/clients', to: 'admin#clients'
      get 'admin/company/:id', to: 'admin#company'

    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
