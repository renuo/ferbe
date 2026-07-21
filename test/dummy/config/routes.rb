Rails.application.routes.draw do
  mount Ferbe::Engine => "/ferbe"

  get root to: "home#index"
  get "/surprise", to: "surprise#index"

  resources :cards, only: [:index, :create, :destroy]
end
