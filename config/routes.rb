Rails.application.routes.draw do
  root "pages#home"

  get "analytics", to: "pages#analytics"

  resources :searches, only: [:create]
end
