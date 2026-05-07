require "test_helper"
require 'ferbe/partial_wrapper'

module Ferbe
  class PartialWrapperTest < ActiveSupport::TestCase
    test "wrapping a simple string" do
      wrapper = Ferbe::PartialWrapper.new("test")
      assert_equal wrapper.wrap("some content"), "<test>some content</test>"
    end
  end
end
