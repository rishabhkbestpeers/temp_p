Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'category/index', to: "category#index"
  get 'search/index', to: "category#search"
  # namespace :admin do
  #   get "session/new", to: "session#new"
  #   post "session/new", to: "session#create"
  #   delete "session/log_out", to: "session#destroy"
  #   get "registration/new", to: "registration#new"
  #   post "registration/new", to: "registration#create"
  # end
   
  # get "/movie/:id/edit", to: "movie#edit"
  get "user_admin", to: "admin#index"
  get "admin_user_access", to: "admin#user_access"
  delete "admin_destroy/:id", to: "admin#destroy", as: "destroy/user"
  
  namespace :user do
    get "registration/new", to: "registration#new"
    post "registration/new", to: "registration#create"
    get "session/new", to: "session#new"
    post "session/new", to: "session#create"
    delete "session/log_out", to: "session#destroy"
  end

  

  resources :movie do
    resource :review, only: [:new, :create]
  end

  
  # get "review/:movie_id/new", to: "review#new"
  # post "review/:movie_id/new", to: "review#create"

  # get "user/review/:movie_id/new", to: "review#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  # Defines the root path route ("/")
  root "home#index"
end
