# frozen_string_literal: true

require "application_system_test_case"

class HappyPathTest < ApplicationSystemTestCase
  setup do
    @template_path = Rails.root.join("app/views/shared/colors/_red.html.erb")
    @template_content = File.read(@template_path)
  end

  test "editor opens with necessary parts" do
    open_template

    assert_text "app/views/home/index.html.erb"
    assert_text "app/views/shared/_grid.html.erb"
    assert_text "app/views/shared/colors/_red.html.erb", minimum: 2

    assert_text @template_content.strip

    assert_link "❌"
    assert_button "💾"
  end

  test "editor can be closed" do
    open_template

    click_link "❌"

    assert_no_text @template_content
  end

  test "template can be modified" do
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

  test "render path can be navigated" do
    open_template

    click_link "app/views/home/index.html.erb"

    assert_no_text @template_content.strip
  end

  private

  def open_template
    visit root_path

    find(".grid .red").click(:alt)

    assert_selector "[data-turbo-permanent]", wait: 10

    assert_selector "#ferbe-editor", wait: 20
  end
end
