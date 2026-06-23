require "test_helper"
require "tempfile"

module Ferbe
  class EditorControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "rejection of editor for invalid template" do
      invalid_path = "some/invalid/file.txt"
      get editor_url, params: {template: {path: invalid_path, render_path: [invalid_path]}, url: "http://example.com"}
      assert_response :bad_request
    end

    test "success for valid template" do
      Tempfile.create(["test", ".html.erb"], Rails.root.join("app/views")) do |file|
        file.write "I am a template!"

        get editor_url, params: {template: {path: file.path, render_path: [file.path]}, url: "http://example.com"}
        assert_response :success
      end
    end
  end
end
