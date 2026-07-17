class SurpriseController < ApplicationController
  @@visit_count = 0

  def show
    @@visit_count += 1

    if @@visit_count >= 3
      @@visit_count = 0
      render :surprise
    end
  end
end
