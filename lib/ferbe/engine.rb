module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    # :nocov: -> covered by manual system tests
    initializer "ferbe.partial_wrapping" do
      next unless Ferbe.configuration.enabled

      require "ferbe/partial_wrapping"

      Ferbe.wrapper_tag = "ferbe-partial"
      Ferbe.partial_wrapper = Ferbe::PartialWrapper.new(Ferbe.wrapper_tag)

      ActiveSupport.on_load(:action_view) do
        ActionView::PartialRenderer.prepend(Ferbe::PartialWrapping)
      end
    end

    initializer "ferbe.view_helpers" do
      ActiveSupport.on_load :action_view do
        require "ferbe/helper"
        ActionView::Base.include Ferbe::Helper
      end
    end

    initializer "ferbe.assets" do |app|
      next unless Ferbe.configuration.enabled

      if app.config.respond_to?(:assets)
        app.config.assets.paths << root.join("app/assets/javascripts")
        app.config.assets.paths << root.join("app/assets/stylesheets")
        app.config.assets.precompile += %w[ferbe/application.css ferbe/highlight.css ferbe/application.js]
      end
    end

    initializer "ferbe.importmap", before: "importmap" do |app|
      next unless Ferbe.configuration.enabled

      if app.respond_to?(:importmap)
        app.config.importmap.paths << root.join("config/ferbe_importmap.rb")
        app.config.importmap.cache_sweepers << root.join("app/assets/javascripts")
      end
    end
  end
end
