json.extract! departure_board, :id, :carrier, :departure_time, :destination, :train, :track, :status, :created_at, :updated_at
json.url departure_board_url(departure_board, format: :json)