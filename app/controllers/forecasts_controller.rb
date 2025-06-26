class ForecastsController < ApplicationController
  def show
    @address = params[:address]

    if @address.present?
      coords = Geocode.get_lat_lon(@address)

      if coords
        # Round to 4 decimal places to normalize keys
        lat = coords[:lat].round(4)
        lon = coords[:lon].round(4)

        # Use lat/lon in the cache key

        cache_key = "forecast_#{lat}_#{lon}"

        Rails.logger.info "Checking cache for key: #{cache_key}"

        # Try to fetch from cache
        cached_data = Rails.cache.read(cache_key)


        if cached_data
          Rails.logger.info "Found data in cache"
          @forecast = cached_data
          @from_cache = true
        else
          Rails.logger.info "Cache miss — calling API"
          # Fetch from met.no API
          @forecast = WeatherForecast.fetch_by_lat_lon(lat, lon)

          if @forecast && @forecast.dig(:current, :temperature)
            Rails.logger.info "Caching forecast for key: #{cache_key}"
            Rails.cache.write(cache_key, @forecast, expires_in: 30.minutes)
          end


          @from_cache = false
        end
      else
        flash.now[:alert] = "Address not found. Please try again."
      end
    end
  end
end
