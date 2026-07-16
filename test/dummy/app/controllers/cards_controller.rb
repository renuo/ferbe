class CardsController < ApplicationController
  before_action :set_card, only: %i[destroy]

  def index
    @cards = Card.all
  end

  def create
    @card = Card.new.save
    redirect_to cards_path
  end

  def destroy
    @card.destroy!
    render
  end

  private

  def set_card
    @card = Card.find(params.expect(:id))
  end
end
