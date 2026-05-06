module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    # if Ferbe.configuration.enabled
    #   # do stuff
    # end
  end
end
