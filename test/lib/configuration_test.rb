require "test_helper"

module Ferbe
  class ConfigurationTest < ActiveSupport::TestCase
    setup do
      Ferbe.configuration = nil
    end

    test "default configuration" do
      config = Ferbe.configuration

      assert config.enabled
      assert_equal config.modifyer_key, "Alt"
      assert_not config.use_local_editor
    end

    test "setting the configuration using a block" do
      Ferbe.configure do |config|
        config.enabled = false
        config.modifyer_key = "Fn"
        config.use_local_editor = true
      end

      config = Ferbe.configuration

      assert_not config.enabled
      assert_not_equal config.modifyer_key, "Alt"
      assert config.use_local_editor
    end
  end
end
