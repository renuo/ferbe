require "ferbe/partial_wrapping"

module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    # :nocov: -> manually tested by T08
    if Ferbe.configuration.enabled
      initializer "ferbe.partial_wrapping" do
        Ferbe.partial_wrapper = Ferbe::PartialWrapper.new("ferbe-partial")

        ActiveSupport.on_load(:action_view) do
          ActionView::PartialRenderer.prepend(Ferbe::PartialWrapping)
        end
      end
    end
    # :nocov:
  end
end
