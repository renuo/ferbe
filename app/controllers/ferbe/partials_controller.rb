module Ferbe
  class PartialsController < ApplicationController
    def edit
      # TODO: Implement
    end

    def update
      partial_params = params.require(:partial).permit(:path, :content)

      return head :bad_request unless valid_path? partial_params[:path]

      File.write(partial_params[:path], partial_params[:content])
    end

    private

    def valid_path?(path)
      File.readable?(path) &&
        path.include?(Rails.root.to_s) &&
        path.ends_with?(".erb")
    end
  end
end
