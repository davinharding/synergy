Rails.application.routes.draw do
  resources :profiles
  get 'hello_world', to: 'hello_world#index'
  devise_for :users
  root 'profiles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :profiles, [:index, :create, :update]
end
