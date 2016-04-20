Rails.application.routes.draw do
  root 'home#show'

  devise_for :users, only: :passwords
  devise_scope :user do
    post 'sign_up', to: 'devise/registrations#create', as: :user_registration
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  get 'sign_up', to: 'devise/registrations#new', as: :new_user_registration
  get 'sign_in', to: 'devise/sessions#new', as: :new_user_session

  resources :gyms, except: :destroy
  resources :sections, only: [:new, :show]
  resources :climbs, only: [:new, :create]
end
