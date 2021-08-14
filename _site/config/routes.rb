Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "about", to: "about#index"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "sign_up", to: "registration#new"
  post "sign_up", to: "registration#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "password/reset", to: "passwords_resets#new"
  post "password/reset", to: "passwords_resets#create"

  get "password/reset/edit", to: "passwords_resets#edit"
  patch "password/reset/edit", to: "passwords_resets#update"

  get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"

  resources :twitter_accounts

  resources :tweets

  
  root to: "main#index"

end
