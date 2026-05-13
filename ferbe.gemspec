require_relative "lib/ferbe/version"

Gem::Specification.new do |spec|
  spec.name = "ferbe"
  spec.version = Ferbe::VERSION
  spec.authors = ["Tim Landolt"]
  spec.email = ["tim.landolt@renuo.ch"]
  spec.homepage = "https://github.com/renuo/ferbe"
  spec.summary = "Faster erb (partial) editing. A gem that adds a split view editor for erb partials."

  spec.metadata["allowed_push_host"] = "TODO: eventually set"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/renuo/ferbe"
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,lib}/**/*", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.1.3"
  spec.add_dependency "turbo-rails", ">= 2.0.23"
  spec.add_dependency "stimulus-rails", "~> 1.3"
end
