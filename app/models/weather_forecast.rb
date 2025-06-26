class WeatherForecast
  include ExternalApiClient

  API_URL = "https://api.met.no/weatherapi/locationforecast/2.0/compact"

  def self.fetch_by_lat_lon(lat, lon)
    new(lat, lon).forecast_data
  end

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def forecast_data
    data = self.class.get_json(API_URL, { lat: @lat, lon: @lon })
    return unless data

    timeseries = data["properties"]["timeseries"]
    return unless timeseries

    {
      current: current_weather(timeseries),
      daily_high_low: today_high_low(timeseries)
    }
  end

  private

  def current_weather(timeseries)
    current = timeseries.first
    {
      time: current["time"],
      temperature: current["data"]["instant"]["details"]["air_temperature"],
      wind_speed: current["data"]["instant"]["details"]["wind_speed"]
    }
  end

  def today_high_low(timeseries)
    today = Date.today
    temps = timeseries.select { |t|
      Time.parse(t["time"]).to_date == today
    }.map { |t|
      t["data"]["instant"]["details"]["air_temperature"]
    }

    return {} if temps.empty?

    {
      high: temps.max,
      low: temps.min
    }
  end
end
