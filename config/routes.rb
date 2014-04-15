Stidentify::Application.routes.draw do
  root :to => "static_pages#home"

  get "static_pages/home"
  get "static_pages/resources"
  get "static_pages/thanks"

  match "/thanks", to: "static_pages#thanks", via: [:get]
  match "/logout", to: "sessions#destroy", via: [:get, :delete]

  post "admin/cms", to: "admin#cms"
  get "admin", to: "admin#sign_in"
  

  resources :users, except: [:index] do
    member do
      get "/search/new"
      post "/search/create"
      get "/search/results"
      get "/compare", to: "users#compare"
      post "/create_compare", to: "users#create_compare"
      get "/results", to: "user#results"
    end
  end

  resource :session

  namespace :api do
    resources :sessions
    resources :matches
  end

  # match 'api/sessions', to: "api/sessions#create", via: [:options]

end
