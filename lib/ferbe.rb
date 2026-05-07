require "ferbe/version"
require "ferbe/configuration"
require "ferbe/engine"

module Ferbe
  class << self
    attr_accessor :partial_wrapper, :wrapper_tag
  end
end
