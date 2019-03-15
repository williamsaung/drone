module Api
  module V1
    class DroneController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :find_user, except: %i[create index]
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        respond_with Drone.all
      end

      def mission_status_change
        @mission = Mission.find(params[:id])

        @drone = Drone.find(@mission.drone.id)
        @drone.status = params[:drone_status]
        @drone.save

        @mission.status = params[:mission_status]
        @mission.save


      end

    end
  end
end