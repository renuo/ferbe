module Ferbe
  module Helper
    #:nocov: -> tested implicitly through all manual system tests
    def ferbe_tags
      return unless Ferbe.configuration.enabled

      capture do
        concat tag.meta(name: "ferbe:modifier-key", content: Ferbe.configuration.modifier_key)
        concat tag.meta(name: "ferbe:use-local-editor", content: Ferbe.configuration.use_local_editor.to_s)
        concat stylesheet_link_tag("ferbe/host", media: "all")
        concat javascript_import_module_tag("ferbe/host")
      end
    end

    #:nocov:
  end
end
