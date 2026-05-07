# frozen_string_literal: true

module Ferbe
  class PartialWrapper
    attr_accessor :tag

    def initialize(tag)
      @tag = tag
    end

    def wrap(body:, path: nil)
      full_path = Rails.root.join(path) if path

      attributes = path ? " path=\"#{path}\" full-path=\"#{full_path}\"" : ""

      "<#{tag}#{attributes}>#{body}</#{tag}>"
    end
  end
end
