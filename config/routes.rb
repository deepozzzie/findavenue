Rails.application.routes.draw do
  resources :companies
  devise_for :users
  resources :indices
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'indices#index'
  get "index", to:  "indices#index"
  get 'home', to: 'indices#home'

  get 'venue', to: "venues#index"
  get "display_venue", to: "venues#show"

  get "getall/all_venues", to: "venues#return_all_venues"

  post 'set_company_capacity', to: 'venues#set_company_capacity'
  post 'change_page', to: 'venues#change_page_percentage_full'
end
