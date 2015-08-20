Rails.application.routes.draw do
  root 'bikes#index'

  resources :bikes, only: [:show, :index]
  resources :brands, :types, only: :show
end
