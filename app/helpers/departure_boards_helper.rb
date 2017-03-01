module DepartureBoardsHelper

  def epoch_to_eastern_time(epoch_time)
    # config.time_zone = "Eastern Time (US & Canada)"
    Time.at(epoch_time.to_i).in_time_zone("Eastern Time (US & Canada)").strftime( "%l:%M %p" )
  end

  def track_num(track_num)
    track_num ? track_num : "TBD"
  end
end
