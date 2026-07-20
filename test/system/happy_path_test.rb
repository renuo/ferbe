# frozen_string_literal: true

require "application_system_test_case"

class HappyPathTest < ApplicationSystemTestCase
  setup do
    @template_path = Rails.root.join("app/views/shared/colors/_red.html.erb")
    @template_content = File.read(@template_path)
  end

  test "opening editor" do
    open_template

    assert_text "app/views/home/index.html.erb"
    assert_text "app/views/shared/_grid.html.erb"
    assert_text "app/views/shared/colors/_red.html.erb"

    assert_text @template_content.strip
  end

  test "closing editor" do
    open_template

    click_link "❌"

    assert_no_text @template_content
  end

  test "modifying template" do
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

    assert_equal "#{new_content}\n", File.read(@template_path)
  ensure
    File.write(@template_path, @template_content)
  end

  test "navigating render path" do
    open_template

    click_link "app/views/home/index.html.erb"

    assert_no_text @template_content.strip
  end

  private

  def open_template
    visit root_path

    find(".grid .red").click(:alt)

    assert_selector "#ferbe-editor", wait: 10
  end
end
