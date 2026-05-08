module Ferbe
  module EditorHelper
    #:nocov: -> tested implicitly through all manual system tests
    def ferbe_editor_tag
      return unless Ferbe.configuration.enabled

      tag.div id: "ferbe-editor"
    end
    #:nocov:
  end
end
