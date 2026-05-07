Rails.application.routes.draw do
  mount Ferbe::Engine => "/ferbe"

  get root to: "home#index"
end
