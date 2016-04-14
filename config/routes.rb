Rails.application.routes.draw do
  root 'home#show'

  resources :gyms, except: :destroy
  resources :sections, only: [:new]
end
