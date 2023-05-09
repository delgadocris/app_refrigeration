Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations', passwords: 'users/passwords' }

  resources :branches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    scope module: :v1 do
      resources :branches, only: %i[by_fridge] do
        collection do
          get 'by_fridge', action: 'by_fridge'
        end
      end
    end
  end

  # Defines the root path route ("/")
  root "branches#index"

  get '*path' => redirect('/')
end
