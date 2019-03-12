class IndexController < ApplicationController
  def index
    last_drone = Drone.order("created_at").last
    @last_drone = last_drone.name
  end
end
