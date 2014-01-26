Debatable::Application.routes.draw do

  resources :initial_users, only: [:create]

  post "admin/cms", to: "admin#cms"
  get "admin", to: "admin#sign_in"


  root :to => "home#landing"

  resources :instructors
  resources :schools, except: [:destroy]
  resources :students
  resources :tutorials
  resources :workshops

  resource :session, only: [:new, :create, :destroy]


end
