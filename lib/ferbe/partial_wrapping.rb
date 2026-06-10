# :nocov: -> covered by manual system tests
require "ferbe/partial_wrapper"

module Ferbe
  module PartialWrapping
    def render(...)
      result = super
      wrapped_body = Ferbe.partial_wrapper.wrap(
        body: result.body,
        path: result.template.identifier
      ).html_safe

      result.class.new(wrapped_body, result.template)
    end
  end
end
