# frozen_string_literal: true

module Ferbe
  class PartialWrapper
    attr_accessor :tag

    def initialize(tag)
      @tag = tag
    end

    def wrap(body:, path: nil)
      "<#{tag}#{" path=\"#{path}\"" if path}>#{body}</#{tag}>"
    end
  end
end
