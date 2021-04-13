Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, :only => [:show]
  resources :reservations
end
