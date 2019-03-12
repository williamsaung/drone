class IndexController < ApplicationController
  def index
    @drone_count = Drone.count
    last_drone = Drone.order("created_at").last
    @last_drone = last_drone.name
    @last_status = last_drone.status
    @nav_logs = NavLog.where(drone:last_drone)
    @last_latitude= @nav_logs.last.gps_latitude
    @last_longitude= @nav_logs.last.gps_longitude


    @mission_count = Mission.count
    last_mission = Mission.order("created_at").last
    @last_mission = last_mission.name
    @last_location = last_mission.location.name
  end
end
