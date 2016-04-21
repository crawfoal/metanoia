Rails.application.routes.draw do
  root 'home#show'

  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
             only: [:new, :create, :edit, :update],
             path: 'users',
             path_names: { new: 'sign_up' },
             controller: 'devise/registrations',
             as: :user_registration do
               get :cancel
             end
  end

  resources :gyms, except: :destroy
  resources :sections, only: [:new, :show]
  resources :climbs, only: [:new, :create]
  resource :profile, only: [:show], controller: :profile
end
