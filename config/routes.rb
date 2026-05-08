Ferbe::Engine.routes.draw do
  resource :partial, only: [:edit, :update]
end
