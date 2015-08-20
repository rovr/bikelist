Rails.application.routes.draw do
  root 'bikes#index'

  resources :bikes, :brands, :types, only: [:show, :index]
end
