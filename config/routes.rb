Rails.application.routes.draw do
  resources :reviews
  resources :books
  resources :authors

  get "/search", :to => "common#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
