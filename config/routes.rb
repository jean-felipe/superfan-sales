Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :products
  resources :companies, only: [:new, :show, :edit]

  namespace :api do
    namespace :v1 do
      resources :products
      resources :companies
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
