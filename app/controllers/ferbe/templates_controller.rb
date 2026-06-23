module Ferbe
  class TemplatesController < ApplicationController
    def edit
      template = edit_params[:template]
      return head :bad_request unless valid_path? template[:path]

      @template = {
        content: File.read(template[:path]),
        path: template[:path],
        render_path: template[:render_path]
      }

      @url = edit_params[:url]
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

    def edit_params
      {
        template: params.require(:template).permit(:path, render_path: []),
        url: params.require(:url)
      }
    end
  end
end
