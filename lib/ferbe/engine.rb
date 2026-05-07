require "ferbe/partial_wrapping"

module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    # :nocov: -> manually tested by T08
    initializer "ferbe.partial_wrapping" do
      next unless Ferbe.configuration.enabled

      Ferbe.wrapper_tag = "ferbe-partial"
      Ferbe.partial_wrapper = Ferbe::PartialWrapper.new(Ferbe.wrapper_tag)

      ActiveSupport.on_load(:action_view) do
        ActionView::PartialRenderer.prepend(Ferbe::PartialWrapping)
      end
    end
    # :nocov:
  end
end
