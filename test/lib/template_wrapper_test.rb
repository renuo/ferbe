require "test_helper"
require "ferbe/template_wrapper"

module Ferbe
  class TemplateWrapperTest < ActiveSupport::TestCase
    setup do
      @wrapper = Ferbe::TemplatelWrapper.new("test")
    end

    test "wrapping a simple string" do
      assert_equal @wrapper.wrap(body: "some content"), "<test>some content</test>"
    end

    test "wrapping a simple string with path" do
      path = Rails.root.join("some/path")

      wrapped_string = @wrapper.wrap(body: "some content", path: path)

      assert_equal wrapped_string, "<test path=\"#{path}\">some content</test>"
    end
  end
end
