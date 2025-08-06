require "sidekiq/web"
Rails.application.routes.draw do
  root "pages#home"

  get "analytics", to: "pages#analytics"
  mount Sidekiq::Web => "/sidekiq"

  resources :searches, only: [:create]
end
