Stidentify::Application.routes.draw do
  root :to => "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  

  resources :users, except: [:index] do
    member do
      get "/search/new"
      post "/search/create"
      get "/search/results"
    end
  end

  resource :session
end
