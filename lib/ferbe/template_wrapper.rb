# frozen_string_literal: true

module Ferbe
  class TemplateWrapper
    attr_accessor :tag

    def initialize(tag)
      @tag = tag
    end

    def wrap(body:, path: nil)
      "<#{tag}#{" path=\"#{path}\"" if path}>#{body}</#{tag}>"
      # content_tag tag, path: path do
      #   body
      # end
    end
  end
end
