class SurpriseController < ApplicationController
  def show
    render :surprise if rand < 0.2
  end
end
