require "ferbe/version"
require "ferbe/configuration"
require "ferbe/engine"
require "turbo-rails"

module Ferbe
  class << self
    attr_accessor :partial_wrapper, :wrapper_tag
  end
end
