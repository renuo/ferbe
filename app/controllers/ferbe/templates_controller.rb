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
      File.readable?(path) &&
        path.include?(Rails.root.to_s) &&
        path.ends_with?(".erb")
    end
  end
end
