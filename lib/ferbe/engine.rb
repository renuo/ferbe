module Ferbe
  if Ferbe.configuration.enabled
    class Engine < ::Rails::Engine
      isolate_namespace Ferbe

      # :nocov: -> manually tested by T08
      initializer "ferbe.partial_wrapping" do
        require "ferbe/partial_wrapping"

        Ferbe.wrapper_tag = "ferbe-partial"
        Ferbe.partial_wrapper = Ferbe::PartialWrapper.new(Ferbe.wrapper_tag)

        ActiveSupport.on_load(:action_view) do
          ActionView::PartialRenderer.prepend(Ferbe::PartialWrapping)
        end
      end
      # :nocov:

      # :nocov: -> the manual tests wouldn't work without this
      initializer "ferbe.view_helpers" do
        ActiveSupport.on_load :action_view do
          require "ferbe/helper"
          ActionView::Base.include Ferbe::Helper
        end
      end
      # :nocov:

      initializer "ferbe.assets" do |app|
        if app.config.respond_to?(:assets)
          app.config.assets.paths << root.join("app/assets/javascripts")
          app.config.assets.paths << root.join("app/assets/stylesheets")
          app.config.assets.precompile += %w[ferbe/application.css ferbe/application.js]
        end
      end

      initializer "ferbe.importmap", before: "importmap" do |app|
        if app.respond_to?(:importmap)
          app.config.importmap.paths << root.join("config/ferbe_importmap.rb")
          app.config.importmap.cache_sweepers << root.join("app/assets/javascripts")
        end
      end
    end
  end
end
