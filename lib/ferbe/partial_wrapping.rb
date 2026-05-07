require 'ferbe/partial_wrapper'

module Ferbe
  module PartialWrapping
    def render(context, options, block)
      result = super
      pp result

      wrapped_body = PartialWrapper.new("test").wrap(result.body).html_safe

      result.class.new(wrapped_body, result.template)
    end
  end
end
