module Api
  module V1
    class DroneController < ApplicationController
      before_action :authorize_request, except: :update
      # before_action :find_user, except: %i[create index]
      protect_from_forgery with: :null_session
      respond_to :json
      def index
        @drone= Drone.find(params[:id])
        respond_with @drone
      end

      def update
        @drone= Drone.find(params[:id])
        @drone.update(drone_params)
      end

      def mission_status_change

        @mission = Mission.find(params[:id])

        @drone = Drone.find(@mission.drone.id)
        @drone.status = params[:drone_status]
        @drone.save

        @mission.status = params[:mission_status]
        @mission.save
        end


      def emergency_mission_sim
        @location = Location.create(:name => "Emergency", :latitude => params[:latitude], :longitude => params[:longitude])
        @drone = Drone.find(1) # sim
        @mission = Mission.create(:name => "Emergency", :weight => 25, :status => "Ongoing", :user_id => 1, :mission_type => "Emergency", :location_id => @location.id, :drone_id => @drone.id)

        connection_string = @drone.connection_string

        child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{params[:latitude]} #{params[:longitude]} #{@mission.id} --drone_id #{@drone.id}")
        # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
        Process.detach(child_pid)
      end

      def drone_params
        params.permit(:status)
      end
    end
  end
end
