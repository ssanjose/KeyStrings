Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # config = ActiveAdmin::Devise.config
  # config[:controllers][:sessions] = "users/sessions"
  # config[:controllers][:registrations] = "devise/registrations"
  # devise_for :users, config

  devise_for :users,
             path:        "auth",
             controllers: { sessions: "users/sessions", registrations: "users/registrations" },
             path_names:  { registration: "register" }

  root to: "main#index"

  get "/about", to: "about#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
