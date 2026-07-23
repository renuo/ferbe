# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require "simplecov"
SimpleCov.start "rails" do
  add_filter "lib/ferbe/version.rb"
  add_filter "lib/generators/ferbe/install/templates"

  # TODO: Remove filters as soon as logic is added
  add_filter "app/controllers/ferbe/application_controller.rb"
  add_filter "app/helpers/ferbe/application_helper.rb"

  enable_coverage :branch
  enable_coverage_for_eval
  minimum_coverage line: 100, branch: 100
end

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

require "capybara-playwright-driver"

Capybara.register_driver :custom_playwright do |app|
  Capybara::Playwright::Driver.new(
    app,
    browser_type: ENV["PLAYWRIGHT_BROWSER"]&.to_sym || :chromium,
    headless: ENV["CI"].present? || ENV["PLAYWRIGHT_HEADLESS"] != "false"
  )
end

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [File.expand_path("fixtures", __dir__)]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures", __dir__) + "/files"
  ActiveSupport::TestCase.fixtures :all
end
