class ForecastsController < ApplicationController

  def show
    @forecast = Forecast.new()
    @forecast.save
    @weather = @forecast.get_weather_data
    @current_weather = @weather.currently

    # @sim_battery = NavLog.where(:drone_id => 1).last.battery_level
    # @real_battery = NavLog.where(:drone_id => 2).last.battery_level
  end

  def details
    @forecast = Forecast.new()
    @forecast.save
    @weather = @forecast.get_weather_data
    @daily_weather = @weather.daily.data.first(7)

  end

end
