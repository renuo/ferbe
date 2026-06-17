module Ferbe
  class TemplatesController < ApplicationController
    def edit
      template_params = params.require(:template).permit(:path, render_path: [])
      return head :bad_request unless valid_path? template_params[:path]

      @template = {
        content: File.read(template_params[:path]),
        path: template_params[:path],
        render_path: template_params[:render_path]
      }

      respond_to do |format|
        format.turbo_stream
        format.html { head :no_content }
      end
    end

    # :nocov: -> covered by manual system tests
    def edit_locally
      template_params = params.require(:template).permit(:path)

      if valid_path? template_params[:path]
        editor_path = ENV["EDITOR"]
        head :ok if system("#{editor_path} #{template_params[:path]}")
      else
        head :bad_request
      end
    end
    # :nocov:

    def update
      template_params = params.require(:template).permit(:path, :content)

      return head :bad_request unless valid_path? template_params[:path]

      File.write(template_params[:path], template_params[:content])
      render turbo_stream: turbo_stream.action(:refresh, "")
    end

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
