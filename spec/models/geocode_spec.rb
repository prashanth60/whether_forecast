require 'rails_helper'

RSpec.describe Geocode, type: :model do
  describe ".get_lat_lon" do
    it "returns lat and lon for a valid address" do
      result = Geocode.get_lat_lon("Bangalore")
      expect(result).to include(:lat, :lon)
    end

    it "returns nil for an invalid address" do
      result = Geocode.get_lat_lon("some gibberish address")
      expect(result).to be_nil
    end
  end
end
