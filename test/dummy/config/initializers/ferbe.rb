Ferbe.configure do |config|
  # Whether the gem is active or not.
  config.enabled = ENV["FERBE_ENABLED"] != "false"

  # The modifier key used for opening a template.
  # The possible options are: "alt", "ctrl", "shift", "ctrl/cmd"
  # config.modifier_key = "alt"

  # Whether the templates should be opened in a local editor instead.
  # If set to true, the editor set in the EDITOR env variable is used.
  # config.use_local_editor = false
end
