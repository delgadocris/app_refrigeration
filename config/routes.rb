Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations', passwords: 'users/passwords' }

  resources :branches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "branches#index"

  get '*path' => redirect('/')
end
