Ferbe::Engine.routes.draw do
  resource :template, only: [:edit, :update] do
    post :edit_locally, on: :collection
  end
end
