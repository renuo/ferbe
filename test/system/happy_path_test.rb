# frozen_string_literal: true

require "application_system_test_case"

class HappyPathTest < ApplicationSystemTestCase
  test "opening editor" do
    visit root_path

    find(".grid .red").click(:alt)

    assert_text "app/views/home/index.html.erb"
    assert_text "app/views/shared/_grid.html.erb"
    assert_text "app/views/shared/colors/_red.html.erb"

    assert_text '<div class="partial red"></div>'
  end
end
