class Departure

  # per http://stackoverflow.com/questions/2680523/dry-ruby-initialization-with-hash-argument
  ATTR_NAMES = ['timestamp', 'origin', 'trip', 'destination', 'scheduledtime', 'lateness', 'track', 'status']

  ATTR_NAMES.each { |a| attr_reader a }

  def initialize(attr_hash={})
    ATTR_NAMES.each do |aname|
      self.instance_variable_set "@#{aname}".to_sym, attr_hash[aname] if not attr_hash[aname].nil?
    end
  end

  def carrier; 'MBTA'; end # The data feed is exclusively for MBTA trips

  def self.find(origin)
    DepartureFeed.get_departures_for_origin(origin)
  end

end
