Stidentify::Application.routes.draw do
  root :to => "static_pages#home"
  get "static_pages/home"
  get "static_pages/resources"

  post "admin/cms", to: "admin#cms"
  get "admin", to: "admin#sign_in"
  

  resources :users, except: [:index] do
    member do
      get "/search/new"
      post "/search/create"
      get "/search/results"
    end
  end

  resource :session
end
