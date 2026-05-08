module Ferbe
  module EditorHelper
    #:nocov: -> tested implicitly through all manual system tests
    def ferbe_editor_tag
      return unless Ferbe.configuration.enabled

      tag.div id: "ferbe-editor", data: {
        modifier_key: Ferbe.configuration.modifier_key
      }
    end
    #:nocov:
  end
end
