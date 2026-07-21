module ApplicationHelper
  def nav_link_to(name, path)
    link_to name, path, class: class_names("button", outline: !current_page?(path))
  end
end
