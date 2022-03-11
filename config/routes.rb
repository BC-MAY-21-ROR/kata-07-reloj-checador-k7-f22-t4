Rails.application.routes.draw do
  resources :attendances
  resources :employees
  resources :admins
  resources :branches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "employees#check"
end
