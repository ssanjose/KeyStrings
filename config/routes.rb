Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # config = ActiveAdmin::Devise.config
  # config[:controllers][:sessions] = "users/sessions"
  # config[:controllers][:registrations] = "devise/registrations"
  # devise_for :users, config

  devise_for :users,
             path:        "auth",
             controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  root to: "main#index"

  get "/about", to: "about#index"

  get "/items/search", to: "items#search"
  resources :items, only: %i[index show]

  post "/categories/filter/:id", to: "categories#search"
  delete "/categories/destroy_picks", to: "categories#destroy_picks"
  resources :categories, only: %i[index show]

  post "/cart/buy", to: "cart#buy"
  post "/cart/add/qty/:id", to: "cart#add"
  post "/cart/subtract/qty/:id", to: "cart#subtract"
  resources :cart, only: %i[index create destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
