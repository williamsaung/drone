module Api
  module V1
    class NavLogsController < ApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def index
        respond_with NavLog.all
      end

      def last_navlog
        respond_with NavLog.last
      end

      def create
        # respond_with NavLog.create(params[:nav_log])

        @nav_log = NavLog.new

        @nav_log.gps_latitude = params[:gps_latitude]
        @nav_log.gps_longitude = params[:gps_longitude]
        @nav_log.altitude = params[:altitude]

        @nav_log.drone_id = params[:drone_id]
        @nav_log.save
      end

    end
  end
end