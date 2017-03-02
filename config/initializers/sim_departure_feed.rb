require "departure_feed"
SimDepartureFeed::DepartureFeed.load_sim_departure_feed_as_json()
DepartureFeed = SimDepartureFeed::DepartureFeed # set simulation as DepartureFeed class
