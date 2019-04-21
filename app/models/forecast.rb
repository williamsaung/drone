class Forecast < ApplicationRecord
  def get_weather_data
    ForecastIO.forecast(14.0754804, 100.6100677, params: { extend: 'hourly'})
  end
end
