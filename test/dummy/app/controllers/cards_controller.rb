class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def create
    Card.new.save
    redirect_to cards_path
  end

  def destroy
    card = Card.find(params.expect(:id))
    card.destroy!
  end
end
