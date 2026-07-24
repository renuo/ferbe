class Ferbe::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)

  def mount_engine
    route 'mount Ferbe::Engine => "/ferbe"'
  end

  def copy_initializer
    copy_file "initializer.rb", "config/initializers/ferbe.rb"
  end

  def add_tags_to_layout
    application_layout = "app/views/layouts/application.html.erb"
    tag = "\n\n  <%= ferbe_tags %>"

    if File.exist?(File.join(destination_root, application_layout))
      insert_into_file application_layout, tag, before: /\s*<\/head>/
    else
      say "The default application.html.erb is missing.", :red
      say "Add the following tag to the head section of your layout:#{tag}"
    end
  end
end
