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

        respond_to do |format|
          if @mission.update(drone_params)
            format.html { redirect_to missions_path, notice: 'Drone status has been updated.' }
            format.json { render :show, status: :ok, location: @mission }
          else
            format.html { render :edit }
            format.json { render json: @mission.errors, status: :unprocessable_entity }
          end
        end
      end

    end
  end
end