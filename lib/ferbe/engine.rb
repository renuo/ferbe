require 'ferbe/partial_wrapping'

module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    initializer "ferbe.partial_wrapping" do
      if Ferbe.configuration.enabled
        # Ferbe.partial_wrapper = Ferbe::PartialWrapper.new("test")

        ActiveSupport.on_load(:action_view) do
          ActionView::PartialRenderer.prepend(Ferbe::PartialWrapping)
        end
      end
    end
  end
end
