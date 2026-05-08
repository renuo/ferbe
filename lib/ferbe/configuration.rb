module Ferbe
  class Configuration
    attr_accessor :enabled, :modifier_key, :use_local_editor

    def initialize
      @enabled = true
      @modifier_key = "alt"
      @use_local_editor = false
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
