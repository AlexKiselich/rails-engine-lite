Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/api/v1/merchants"


  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchants/items"
      end
      resources :items do
        resources :merchant, only: [:index], controller: "items/merchant"
      end
    end
  end
end
