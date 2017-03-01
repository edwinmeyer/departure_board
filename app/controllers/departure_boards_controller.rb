class DepartureBoardsController < ApplicationController
  before_action :set_departure_board, only: [:show]

  ::DepartureBoard # This kludge is required in Heroku (but not localhost) for some reason

  def index
    @origins = DepartureBoard.origins
  end

  private
    def set_departure_board
      @departure_board = DepartureBoard.find(params[:id])
    end
end
