module DepartureBoardsHelper

  MAX_DISPLAYED_DEPARTURES = 12

  def epoch_to_eastern_time(epoch_time)
    # config.time_zone = "Eastern Time (US & Canada)"
    Time.at(epoch_time.to_i).in_time_zone("Eastern Time (US & Canada)").strftime( "%l:%M %p" )
  end

  def track_num(track_num)
    track_num ? track_num : "TBD"
  end

  def sort_limit(departures)
    departures.sort {|d1, d2| d1.scheduledtime <=> d2.scheduledtime}[0...MAX_DISPLAYED_DEPARTURES]
  end
end
