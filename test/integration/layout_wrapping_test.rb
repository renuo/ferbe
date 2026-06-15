require "test_helper"

class LayoutWrappingTest < ActionDispatch::IntegrationTest
  test "layout is not wrapped" do
    get "/"
    assert_response :success

    assert_match(/\A<!DOCTYPE html>/, @response.body)
    refute_match(/\A<ferbe-partial/, @response.body)
  end
end
