class IndexController < ApplicationController
  def index
    @drone_count = Drone.count
    last_drone = Drone.order("created_at").last
    if last_drone.blank?
      @last_drone
      @last_status
    else
      @last_drone = last_drone.name
      @last_status = last_drone.status
    end



    @nav_logs = NavLog.where(drone:last_drone)
    if @nav_logs.blank?
      @last_latitude
      @last_longitude
    else
      @last_latitude= @nav_logs.last.gps_latitude
      @last_longitude= @nav_logs.last.gps_longitude
    end


    @mission_count = Mission.count
    last_mission = Mission.order("created_at").last
    if last_mission.blank?
      @last_mission
      @last_location
    else
      @last_mission = last_mission.name
      @last_location = last_mission.location.name
    end

    @sim_battery = NavLog.where(:drone_id => 1).last.battery_level
    @real_battery = NavLog.where(:drone_id => 2).last.battery_level
  end
  end

