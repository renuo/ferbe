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
    template_path = Rails.root.join("app/views/shared/colors/_red.html.erb")
    original_content = File.read(template_path)
    new_content = "<div>MODIFIED TEMPLATE</div>"

    open_template

    input = find(".hljs-string").native
    page.driver.browser.action
      .move_to(input)
      .double_click
      .click
      .perform
    input.send_keys new_content
    click_button "commit"

    assert_no_selector "turbo-frame[busy]", visible: :all

    assert_equal "#{new_content}\n", File.read(template_path)
  ensure
    File.write(template_path, original_content)
  end

  private

  def open_template
    visit root_path

    find(".grid .red").click(:alt)

    assert_selector "#ferbe-editor", wait: 10
  end
end
