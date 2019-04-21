class Forecast < ApplicationRecord

  def get_weather_data
    ForecastIO.forecast(14.0754804, 100.6100677, params: { exclude: 'minutely, hourly'})
  end

  # def get_hourly_weather
  #   ForecastIO.forecast(14.0754804, 100.6100677, params: { extend: 'hourly', exclude: 'currently, minutely'})
  # end
end
