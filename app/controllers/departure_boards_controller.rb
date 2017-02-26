class DepartureBoardsController < ApplicationController
  before_action :set_departure_board, only: [:show]

  # GET /departure_boards
  # GET /departure_boards.json
  def index
    # @departure_boards = DepartureBoard.all
    @departure_boards = []
    render plain: 'Display of all Departure Boards not yet implemented'
  end
  # GET /departure_boards/1
  # GET /departure_boards/1.json
  def show
    render plain: 'Display of a specific Departure Board not yet implemented'
  end

=begin
  # GET /departure_boards/new
  def new
    @departure_board = DepartureBoard.new
  end

  # GET /departure_boards/1/edit
  def edit
  end

  # POST /departure_boards
  # POST /departure_boards.json
  def create
    @departure_board = DepartureBoard.new(departure_board_params)

    respond_to do |format|
      if @departure_board.save
        format.html { redirect_to @departure_board, notice: 'Departure board was successfully created.' }
        format.json { render :show, status: :created, location: @departure_board }
      else
        format.html { render :new }
        format.json { render json: @departure_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departure_boards/1
  # PATCH/PUT /departure_boards/1.json
  def update
    respond_to do |format|
      if @departure_board.update(departure_board_params)
        format.html { redirect_to @departure_board, notice: 'Departure board was successfully updated.' }
        format.json { render :show, status: :ok, location: @departure_board }
      else
        format.html { render :edit }
        format.json { render json: @departure_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departure_boards/1
  # DELETE /departure_boards/1.json
  def destroy
    @departure_board.destroy
    respond_to do |format|
      format.html { redirect_to departure_boards_url, notice: 'Departure board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departure_board
      # @departure_board = DepartureBoard.find(params[:id])
      @departure_board = nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departure_board_params
      params.require(:departure_board).permit(:carrier, :departure_time, :destination, :train, :track, :status)
    end
end
