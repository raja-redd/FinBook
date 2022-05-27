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
  get 'privacy/:id1/:id2', to: "stocks#privacy"
  get 'follow/:id', to: "users#follow"
  get 'unfollow/:id', to: "users#unfollow"
  get 'following/:id', to: 'users#following'
  get 'requestt/:id', to: 'users#requestt'
  get 'removee/:id', to: 'users#removee'
  get 'requests/:id', to: 'users#requests'
  get 'acceptt/:id', to: 'users#acceptt'
  get 'friends/:id', to: 'users#friends'
end
