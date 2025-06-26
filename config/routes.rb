Rails.application.routes.draw do

  root "forecasts#show"
  get "/forecast", to: "forecasts#show"

end
