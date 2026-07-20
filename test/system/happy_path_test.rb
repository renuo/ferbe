# frozen_string_literal: true

require "application_system_test_case"

class HappyPathTest < ApplicationSystemTestCase
  test "opening editor" do
    open_template

    assert_text "app/views/home/index.html.erb"
    assert_text "app/views/shared/_grid.html.erb"
    assert_text "app/views/shared/colors/_red.html.erb"

    assert_text '<div class="partial red"></div>'
  end

  test "modify template" do
    open_template

    input = find(".hljs-string").native
    page.driver.browser.action
        .move_to(input)
        .double_click
        .click
        .perform
    input.send_keys "<div>MODIFIED TEMPLATE</div>"
    click_button "commit"
  end

  private

  def open_template
    visit root_path

    find(".grid .red").click(:alt)
  end
end
