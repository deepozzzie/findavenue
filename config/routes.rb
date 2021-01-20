Rails.application.routes.draw do
  resources :companies
  devise_for :users,
    controllers: {:registrations => "user/registrations"}
  resources :indices
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  as :user do
    get "/register", to: "registrations#new", as: "register"
  end
  root 'indices#home'
  get "dashboard", to:  "companies#index"
  get 'home', to: 'indices#home'
  get 'audit', to: 'companies#audit'

  get 'venue', to: "venues#index"
  get "display_venue", to: "venues#show"

  get "getall/all_venues", to: "venues#return_all_venues"

  post 'set_company_capacity', to: 'venues#set_company_capacity'
  post 'change_page', to: 'venues#change_page_percentage_full'
  post 'add_patron', to: 'indices#add_patron_to_venue'
  post 'contact_us', to: 'indices#contact_us'
  post 'request_company', to: 'indices#request_company'
  post 'message_patron', to: 'companies#message_patron', as: "message_patron"
end
