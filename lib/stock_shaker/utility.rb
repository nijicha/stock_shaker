module StockShaker
  class Utility

    # Parse format for Lazada Open Platform
    def self.datetime_to_iso8601_format(datetime)
      time_format = '%Y-%m-%dT%H:%M:%S'
      datetime.strftime(time_format)
    end
  end
end