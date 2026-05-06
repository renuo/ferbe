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
  end
end
