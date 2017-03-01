class DepartureBoard

  def self.origins()
    DepartureFeed.get_origins
  end

  def self.find(origin)
    departure_instances = []
    departures = DepartureFeed.get_departures_for_origin(origin)
    departures.each do |dep|
      departure_instances << Departure.new(dep)
    end
    departure_instances
  end

end
