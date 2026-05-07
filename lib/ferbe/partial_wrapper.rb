# frozen_string_literal: true

module Ferbe
  class PartialWrapper
    attr_accessor :tag

    def initialize(tag)
      @tag = tag
    end

    def wrap(partial)
      "<#{tag}>#{partial}</#{tag}>"
    end
  end
end
