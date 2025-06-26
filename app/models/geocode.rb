class Geocode
  include ExternalApiClient

  NOMINATIM_URL = "https://nominatim.openstreetmap.org/search"

  def self.get_lat_lon(address)
    result = get_json(NOMINATIM_URL, {
      q: address,
      format: "json",
      limit: 1
    })

    return unless result&.first

    {
      lat: result.first["lat"].to_f,
      lon: result.first["lon"].to_f
    }
  end
end
