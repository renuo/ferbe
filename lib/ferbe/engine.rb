module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    if Ferbe.configuration.enabled
      # TODO: Add stuff
    end
  end
end
