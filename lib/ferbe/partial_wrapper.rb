# frozen_string_literal: true

module Ferbe
  class PartialWrapper
    attr_accessor :tag

    def initialize(tag)
      @tag = tag
    end

    def wrap(body:, path: nil)
      full_path = Rails.root.join(path) if path

      opening_tag = "<#{tag}#{" path=\"#{path}\" full-path=\"#{full_path}\"" if path}>"
      closing_tag = "</#{tag}>"

      "#{opening_tag}#{body}#{closing_tag}"
    end
  end
end
