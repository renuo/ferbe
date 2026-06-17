# frozen_string_literal: true

module Ferbe
  class TemplateWrapper
    include ActionView::Helpers::TagHelper

    attr_accessor :tag

    def initialize(tag)
      @tag = tag
    end

    def wrap(body:, path: nil)
      content_tag(tag, body, path:)
    end
  end
end
