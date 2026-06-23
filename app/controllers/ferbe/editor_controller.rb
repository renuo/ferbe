module Ferbe
  class EditorController < ApplicationController
    def show
      template = editor_params[:template]
      return head :bad_request unless valid_path? template[:path]

      @template = {
        content: File.read(template[:path]),
        path: template[:path],
        render_path: template[:render_path]
      }

      @url = editor_params[:url]
    end

    def editor_params
      {
        template: params.require(:template).permit(:path, render_path: []),
        url: params.require(:url)
      }
    end
  end
end
