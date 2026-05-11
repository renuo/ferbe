module Ferbe
  module Helper
    #:nocov: -> tested implicitly through all manual system tests
    def ferbe_styles_tag
      capture do
        concat stylesheet_link_tag "ferbe/highlight", media: "all"
        concat stylesheet_link_tag "ferbe/application", media: "all"
      end
    end

    def ferbe_javascript_tag
      javascript_import_module_tag "ferbe"
    end

    def ferbe_editor_tag
      return unless Ferbe.configuration.enabled

      tag.div class: "ferbe__editor", id: "ferbe-editor", data: {
        modifier_key: Ferbe.configuration.modifier_key,
        turbo_permanent: true
      }
    end
    #:nocov:
  end
end
