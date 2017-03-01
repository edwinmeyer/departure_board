class DepartureBoardsController < ApplicationController
  before_action :set_departure_board, only: [:show]

  def index
    @origins = DepartureBoard.origins
  end

  private
    def set_departure_board
      @departure_board = DepartureBoard.find(params[:id])
    end
end
