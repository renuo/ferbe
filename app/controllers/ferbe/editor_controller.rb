module Ferbe
  class EditorController < ApplicationController
    def show
      @template = {
        content: File.read(editor_params[:template][:path]),
        path: editor_params[:template][:path],
        render_path: editor_params[:template][:render_path]
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
