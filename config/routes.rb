Rails.application.routes.draw do
 root 'books#top'
 resources :books
 get 'home/about' =>'books#about'
 devise_for :users
 resources :users, only: [:show,:edit,:update,:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
