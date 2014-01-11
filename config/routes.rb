Debatable::Application.routes.draw do

  resources :initial_users, only: [:create]

  root :to => "home#landing"

end
