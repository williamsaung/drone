module Api
  module V1
    class NavLogsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def index
        respond_with NavLog.all
      end

      def last_navlog
        @drone= Drone.find(params[:id])
        @nav_logs = NavLog.where(drone: @drone)
        respond_with @nav_logs.last
      end



      def create
        # respond_with NavLog.create(params[:nav_log])

        @nav_log = NavLog.new

        @nav_log.gps_latitude = params[:gps_latitude]
        @nav_log.gps_longitude = params[:gps_longitude]
        @nav_log.altitude = params[:altitude]
        @nav_log.battery_voltage = params[:battery_voltage]
        @nav_log.battery_level = params[:battery_level]
        @nav_log.battery_current = params[:battery_current]
        @nav_log.ekf_ok = params[:ekf_ok]
        @nav_log.is_armable = params[:is_armable]
        @nav_log.system_status= params[:system_status]
        @nav_log.mode= params[:mode]
        @nav_log.armed= params[:armed]
        @nav_log.drone_id = params[:drone_id]
        @nav_log.save
      end

    end
  end
end