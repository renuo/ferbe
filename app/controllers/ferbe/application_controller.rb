module Ferbe
  class ApplicationController < ::ApplicationController
    private

    def valid_path?(path)
      expanded_path = File.expand_path path

      File.readable?(expanded_path) &&
        view_path?(expanded_path) &&
        expanded_path.ends_with?(".erb")
    end

    def view_path?(path)
      view_paths.any? { |view_path| path.starts_with?(view_path.to_s) }
    end
  end
end
