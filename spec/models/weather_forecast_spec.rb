require 'rails_helper'

RSpec.describe WeatherForecast, type: :model do
  describe ".fetch_by_lat_lon" do
    it "returns forecast with temperature and high/low" do
      forecast = WeatherForecast.fetch_by_lat_lon(12.9716, 77.5946)
      expect(forecast).to include(:current, :daily_high_low)
      expect(forecast[:current]).to include(:temperature)
    end
  end
end
