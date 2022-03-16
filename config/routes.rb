Rails.application.routes.draw do
  devise_for :admins
  resources :attendances
  resources :employees
  resources :branches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get "log_in", to: "admins#log_in"

  # Defines the root path route ("/")
  root "employees#check"
end
