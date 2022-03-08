Rails.application.routes.draw do
  resources :recipes
  default_url_options :only_path => true
  devise_for :users

  resources :users do
    resources :foods, only: %i[index new create destroy]
    resources :recipes
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "foods#index"
end
