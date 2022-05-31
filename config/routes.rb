Rails.application.routes.draw do
  apipie

  root to: 'apipie/apipies#index'

  namespace :api do
    namespace :v1 do
      resources :service_providers

      resources :sessions do
        collection do
          post 'digest'
        end
      end

      resources :geolocations, only: :create
      resources :geolocations, only: [:show, :edit, :update, :destroy], param: :lookup_address
    end
  end
end
