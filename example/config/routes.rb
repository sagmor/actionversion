Rails.application.routes.draw do
  get :profile, to: 'profiles#perform', format: false

  resources :books, only: [:index, :show], format: false
end
