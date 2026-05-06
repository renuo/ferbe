class Ferbe::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def mount_engine
    route 'mount Ferbe::Engine => "/ferbe"'
  end
end
