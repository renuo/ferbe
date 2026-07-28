module Ferbe
  class Engine < ::Rails::Engine
    isolate_namespace Ferbe

    # :nocov: -> covered by manual system tests
    initializer "ferbe.template_wrapping" do
      next unless Ferbe.configuration.enabled

      require "ferbe/template_wrapping"

      Ferbe.wrapper_tag = "ferbe-template"
      Ferbe.template_wrapper = Ferbe::TemplateWrapper.new(Ferbe.wrapper_tag)

      ActiveSupport.on_load(:action_view) do
        ActionView::Template.prepend(Ferbe::TemplateWrapping)
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
      next unless app.config.respond_to?(:assets)

      asset_paths = [
        ["app", "assets", "javascripts"],
        ["app", "assets", "stylesheets"]
      ]

      paths_to_precompile = asset_paths.flat_map do |path|
        app.config.assets.paths << Engine.root.join(*path)

        Dir[Engine.root.join(*path, "**", "*")].filter_map do |file|
          next unless File.file?(file)

          Pathname.new(file).relative_path_from(Engine.root.join(*path)).to_s
        end
      end

      app.config.assets.precompile += paths_to_precompile
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
