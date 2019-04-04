class ForecastsController < ApplicationController
  def show
    # @forecast = Forecast.new(:lat => 14.0754804, :lng => 100.6100677)
    # @forecast.save
    # @weather = @forecast.get_weather_data
    # @current_weather = @weather.currently
  end

  def details
    @forecast = Forecast.new(:lat => 14.0754804, :lng => 100.6100677)
    @forecast.save
    @weather = @forecast.get_weather_data
    # @daily_summary = @weather.daily.summary
    @daily_weather = @weather.daily.data.first(7)
    # @forecast.summary = @weather.daily.summary
    @hourly_weather = @weather.hourly.data.first(23)
  end

  def delivery
    @forecast = Forecast.new(:lat => 14.0754804, :lng => 100.6100677)
    @forecast.save
    @weather = @forecast.get_weather_data
    @current_weather = @weather.currently
  end

  def open_door

  end
end
