require "test_helper"
require "generators/ferbe/install/install_generator"

module Ferbe
  class Ferbe::InstallGeneratorTest < Rails::Generators::TestCase
    tests Ferbe::InstallGenerator
    destination Rails.root.join("tmp/generators")
    setup do
      prepare_destination
      FileUtils.mkdir_p(File.join(destination_root, "config"))
      File.write(File.join(destination_root, "config/routes.rb"), "Rails.application.routes.draw do\nend\n")
    end

    test "generator mounts the engine" do
      run_generator

      assert_file "config/routes.rb" do |routes|
        assert_match 'mount Ferbe::Engine => "/ferbe"', routes
      end
    end

    test "generator generates configuration" do
      run_generator

      assert_file "config/initializers/ferbe.rb" do |config|
        assert_match "Ferbe.configure do |config|", config
      end
    end

    test "generator adds ferbe_tags to application layout when it exists" do
      layout_dir = File.join(destination_root, "app/views/layouts")
      FileUtils.mkdir_p(layout_dir)
      layout_content = <<~HTML
        <!DOCTYPE html>
        <html>
          <head>
            <title>Test App</title>
          </head>
          <body>
            <%= yield %>
          </body>
        </html>
      HTML
      File.write(File.join(layout_dir, "application.html.erb"), layout_content)

      run_generator

      assert_file "app/views/layouts/application.html.erb" do |layout|
        assert_match "<%= ferbe_tags %>", layout
        assert_match(/<%=\s*ferbe_tags\s*%>\s*<\/head>/, layout)
      end
    end

    test "generator shows message when application layout is missing" do
      output = run_generator

      assert_match "The default application.html.erb is missing.", output
      assert_match "Add the following tag to the head section of your layout:", output
      assert_match "<%= ferbe_tags %>", output
    end
  end
end
