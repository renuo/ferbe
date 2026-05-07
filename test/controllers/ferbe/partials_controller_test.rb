require "test_helper"
require "tempfile"

module Ferbe
  class PartialsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "rejection of path outside Rails root" do
      patch partial_url, params: {partial: {path: "/some/path", content: "hello"}}
      assert_response :bad_request
    end

    test "rejection of non-erb path" do
      Tempfile.create(["test", ".rb"], Rails.root.join("tmp")) do |file|
        patch partial_url, params: {partial: {path: file.path, content: "bar"}}
        assert_response :bad_request
      end
    end

    test "rejection of unreadable path" do
      path = Rails.root.join("tmp/non_existent.erb").to_s
      patch partial_url, params: {partial: {path: path, content: "bar"}}
      assert_response :bad_request
    end

    test "update valid path" do
      Tempfile.create(["test", ".erb"], Rails.root.join("tmp")) do |file|
        new_content = "new content"

        patch partial_url, params: {partial: {path: file.path, content: new_content}}

        assert_response :success
        assert_equal new_content, File.read(file.path)
      end
    end
  end
end
