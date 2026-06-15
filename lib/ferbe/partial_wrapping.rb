# :nocov: -> covered by manual system tests
require "ferbe/partial_wrapper"

module Ferbe
  module PartialWrapping
    def render(...)
      content = super
      return content if skip_wrapping?

      Ferbe.partial_wrapper.wrap(
        body: content,
        path: identifier
      ).html_safe
    end

    private

    def skip_wrapping?
      return true if identifier.include?("app/views/layouts/")
      return true if identifier.include?("app/views/ferbe/")

      false
    end
  end
end
