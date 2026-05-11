module Ferbe
  class PartialsController < ApplicationController
    def edit
      partial_params = params.require(:partial).permit(:path, render_path: [])
      return head :bad_request unless valid_path? partial_params[:path]

      @partial = {
        content: File.read(partial_params[:path]),
        path: partial_params[:path],
        render_path: partial_params[:render_path]
      }

      respond_to do |format|
        format.turbo_stream
        format.html { head :no_content }
      end
    end

    def update
      partial_params = params.require(:partial).permit(:path, :content)

      return head :bad_request unless valid_path? partial_params[:path]

      File.write(partial_params[:path], partial_params[:content])
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
