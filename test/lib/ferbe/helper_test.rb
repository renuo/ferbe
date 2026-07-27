# frozen_string_literal: true

require "test_helper"
require "ferbe/helper"

module Ferbe
  class HelperTest < ActionView::TestCase
    include Ferbe::Helper
    include Importmap::ImportmapTagsHelper

    test "ferbe_tags returns nil when ferbe is disabled" do
      Ferbe.configuration.enabled = false
      assert_nil ferbe_tags
    end

    test "ferbe_tags returns correct tags" do
      Ferbe.configuration.enabled = true
      Ferbe.configuration.modifier_key = "ctrl"
      Ferbe.configuration.use_local_editor = true

      result = ferbe_tags
      
      assert_not_nil result
      assert_includes result, '<meta name="ferbe:modifier-key" content="ctrl">'
      assert_includes result, '<meta name="ferbe:use-local-editor" content="true">'
      assert_includes result, '<meta name="ferbe:mount-path" content="/ferbe">'
      assert_includes result, 'link rel="stylesheet" href="/stylesheets/ferbe/host.css"'
      assert_includes result, '<script type="module">import "ferbe/host"</script>'
    end

    test "ferbe_meta_tags returns nil when ferbe is disabled" do
      Ferbe.configuration.enabled = false
      assert_nil ferbe_meta_tags
    end

    test "ferbe_meta_tags returns correct meta tags" do
      Ferbe.configuration.enabled = true
      Ferbe.configuration.modifier_key = "alt"
      Ferbe.configuration.use_local_editor = false

      result = ferbe_meta_tags

      assert_not_nil result
      assert_includes result, '<meta name="ferbe:modifier-key" content="alt">'
      assert_includes result, '<meta name="ferbe:use-local-editor" content="false">'
      assert_includes result, '<meta name="ferbe:mount-path" content="/ferbe">'
    end
  end
end
