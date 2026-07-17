require "application_system_test_case"

class TeestTest < ApplicationSystemTestCase
  test "some thing" do
    visit root_path

    assert_text "Welcome to the Homepage"
  end
end
