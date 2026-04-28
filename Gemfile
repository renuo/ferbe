source "https://rubygems.org"

# Specify your gem's dependencies in ferbe.gemspec.
gemspec

gem "puma"
gem "sqlite3"
gem "propshaft"

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

group :development, :test do
  gem "erb_lint", require: false
  gem "standard"
end

group :test do
  gem "simplecov", require: false
end
