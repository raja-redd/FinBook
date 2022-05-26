Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  resources :stocks
  # get 'stocks', to 'stocks#index'
  resources :users
  get 'signup', to: 'users#new'

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
  get 'myport/:id', to: "stocks#myport"
  get 'add/:id', to: "stocks#add"
  get 'delete/:id', to: "stocks#delete"
  # get 'controller/stock/add'
  
end
