Weather Forecast App (Rails + Redis + met.no):

A simple but production-quality Ruby on Rails app that accepts an address, retrieves the weather forecast using met.no, and caches results for 30 minutes using Redis. 

<------------------------------------------------------------------------------------------>

Features:

Enter any address and get weather forecast for that location

<------------------------------------------------------------------------------------------>

Shows:

Current temperature

Wind speed

Daily high and low temperatures

Caches forecast by lat/lon for 30 minutes using Redis

Detects and indicates cache hits vs live API calls

Follows enterprise coding standards (modular, testable, documented)

<------------------------------------------------------------------------------------------>


Tech Stack:

Ruby on Rails 6.1

Redis for caching via redis_cache_store

HTTParty for API requests

Nominatim (OpenStreetMap) for geocoding

met.no for weather forecast

RSpec for unit testing

<------------------------------------------------------------------------------------------>


Setup Instructions:

# Clone the repo
bundle install

# Enable Redis caching in development
touch tmp/caching-dev.txt

# Start Redis server (if not already running)
redis-server

# Run the app
bin/rails server

Redis Setup in config/environments/development.rb

config.cache_store = :redis_cache_store, {
  url: "redis://localhost:6379/0",
  namespace: "weather-dev-cache"
}

<------------------------------------------------------------------------------------------>

API References

Geocoding: https://nominatim.openstreetmap.org/search?q=<query>&format=json

Forecast: https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=<lat>&lon=<lon>

<------------------------------------------------------------------------------------------>


To Run The Tests:

bundle exec rspec
<------------------------------------------------------------------------------------------>


