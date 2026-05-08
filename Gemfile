source "https://rubygems.org"

ruby File.read(File.join(__dir__, ".ruby-version"))

gemspec

gem "puma"
gem "sqlite3"
gem "propshaft"
gem "importmap-rails"

group :development, :test do
  gem "erb_lint", require: false
  gem "standard"
end

group :test do
  gem "simplecov", require: false
end

gem "stimulus-rails", "~> 1.3"
