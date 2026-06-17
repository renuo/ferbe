require "test_helper"
require "tempfile"

module Ferbe
  class TemplatesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "rejection of path outside Rails root" do
      patch template_url, params: {template: {path: "/some/path", content: "hello"}}
      assert_response :bad_request
    end

    test "protection from directory traversal" do
      Tempfile.create(["test", ".erb"]) do |file|
        depth = Rails.root.to_s.split(File::SEPARATOR).count
        traversal_dots = "../" * depth
        traversed_file = File.join(Rails.root.to_s, traversal_dots, file)

        patch template_url, params: {template: {path: traversed_file, content: "bar"}}
        assert_response :bad_request
      end
    end

    test "rejection of non-erb path" do
      Tempfile.create(["test", ".rb"], Rails.root.join("tmp")) do |file|
        patch template_url, params: {template: {path: file.path, content: "bar"}}
        assert_response :bad_request
      end
    end

    test "rejection of unreadable path" do
      path = Rails.root.join("tmp/non_existent.erb").to_s
      patch template_url, params: {template: {path: path, content: "bar"}}
      assert_response :bad_request
    end

    test "update valid path" do
      Tempfile.create(["test", ".erb"], Rails.root.join("tmp")) do |file|
        new_content = "new content"

        patch template_url, params: {template: {path: file.path, content: new_content}}

        assert_response :success
        assert_equal new_content, File.read(file.path)
      end
    end

    test "edit as html returns no content" do
      Tempfile.create(["test", ".html.erb"], Rails.root.join("tmp")) do |file|
        file.write "I am a template!"

        get edit_template_url, params: {template: {path: file.path}}
        assert_response :no_content
      end
    end

    test "reject editing of invalid template" do
      get edit_template_url, params: {template: {path: "some/invalid/file.txt"}}
      assert_response :bad_request
    end
  end
end
