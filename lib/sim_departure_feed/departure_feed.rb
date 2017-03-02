require 'csv'
require 'json'

module SimDepartureFeed
  class DepartureFeed
    def self.load_sim_departure_feed_as_json()
      csv_text = File.read(Rails.root.join('lib', 'sim_departure_feed', 'sim_departures.csv'))
      json_serialized = csv_to_json(csv_text)

      File.open(Rails.root.join('lib', 'sim_departure_feed', 'sim_departures.json'), 'w') do |f|
        f << json_serialized
      end
    end

    def self.get_origins
      departures_as_hash = get_sim_departures_as_hash
      departures_as_hash.map {|departure| departure['origin']}.uniq
    end

    def self.get_departures_for_origin(origin)
      departures_as_hash = get_sim_departures_as_hash
      departures_as_hash.select {|departure| departure['origin'] == origin}
    end

    private
    def self.get_sim_departures_as_hash
      json_serialized = File.open(Rails.root.join('lib', 'sim_departure_feed', 'sim_departures.json'),
                               'r') { |file| file.read }
      json_parsed = JSON.parse(json_serialized)
      json_parsed
    end

    # Modified from https://gist.github.com/enriclluelles/1423950
    def self.csv_to_json(csv_text)
      lines = CSV.parse(csv_text)
      keys = lines.delete lines.first
      keys.map! {|k| k.downcase}

      data = lines.map do |values|
        Hash[keys.zip(values)]
      end
      JSON.generate(data)
    end
  end
end
