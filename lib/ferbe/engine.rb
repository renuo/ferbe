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

    # :nocov: -> the manual tests wouldn't work without this
    initializer "ferbe.helpers" do
      ActiveSupport.on_load(:action_view) do
        include Ferbe::EditorHelper
      end
    end
    # :nocov:

    initializer "ferbe.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
    end

    initializer "ferbe.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end
  end
end
