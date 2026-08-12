module Ferbe
  module Helper
    def ferbe_tags
      return unless Ferbe.configuration.enabled

      capture do
        concat ferbe_meta_tags
        concat stylesheet_link_tag("ferbe/host", media: "all")
        concat javascript_import_module_tag("ferbe/host")
      end
    end

    def ferbe_meta_tags
      return unless Ferbe.configuration.enabled

      capture do
        concat tag.meta(name: "ferbe:modifier-key", content: Ferbe.configuration.modifier_key)
        concat tag.meta(name: "ferbe:use-local-editor", content: Ferbe.configuration.use_local_editor.to_s)
        concat tag.meta(name: "ferbe:mount-path", content: Rails.application.routes.url_helpers.ferbe_path)
      end
    end
  end
end
