# frozen_string_literal: true

module StockShaker
  class Utility

    # Parse format for Lazada Open Platform
    def self.datetime_to_iso8601(datetime)
      time_format = '%Y-%m-%dT%H:%M:%S'
      datetime.strftime(time_format)
    end

    def self.datetime_to_timestamp(datetime)
      datetime.to_time.to_i
    end
  end
end