Rails.application.routes.draw do
  root 'home#show'

  resources :gyms, only: [:new, :create, :index]
  resources :sections, only: [:new]
end
