require "test_helper"

module Ferbe
  class ConfigurationTest < ActiveSupport::TestCase
    setup do
      Ferbe.configuration = nil
    end

    test "default configuration" do
      config = Ferbe.configuration

      assert config.enabled
      assert_equal config.modifier_key, "alt"
      assert_not config.use_local_editor
    end

    test "setting the configuration using a block" do
      Ferbe.configure do |config|
        config.enabled = false
        config.modifier_key = "fn"
        config.use_local_editor = true
      end

      config = Ferbe.configuration

      assert_not config.enabled
      assert_not_equal config.modifier_key, "alt"
      assert config.use_local_editor
    end
  end
end
