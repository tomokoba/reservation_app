Rails.application.routes.draw do
  root to: 'reservations#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, :only => [:show]
  resources :reservations
end
