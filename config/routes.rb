Ferbe::Engine.routes.draw do
  resource :partial, only: [:edit, :update] do
    post :edit_locally, on: :collection
  end
end
