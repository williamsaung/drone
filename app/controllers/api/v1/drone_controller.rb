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

      def terminate_mission
        @mission = Mission.find(params[:id])
        @drone = Drone.find(@mission.drone.id)
        @drone.status = params[:drone_status]
        @drone.save
        @mission.status = params[:mission_status]
        @mission.save

        if @drone.simulator?
          child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/rtl.py")
          # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
          # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
          Process.detach(child_pid)
        else
          child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/rtl.py --port 9091")
          # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
          # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
          Process.detach(child_pid)
        end
      end

      def mission_status_change

        @mission = Mission.find(params[:id])
        gps_latitude = @mission.location.latitude
        gps_longitude = @mission.location.longitude

        @drone = Drone.find(@mission.drone.id)
        @drone.status = params[:drone_status]
        @drone.save

        @mission.status = params[:mission_status]
        @mission.save

        connection_string = @drone.connection_string
        puts "Executing command 'python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude}'"

        # For simulators
        if @drone.simulator?
          child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{gps_latitude} #{gps_longitude} 20 #{@mission.id} --drone_id #{@drone.id}")
          # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
          Process.detach(child_pid)
        else
          child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{gps_latitude} #{gps_longitude} 20 #{@mission.id} --drone_id #{@drone.id} --port 9091")
          # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
          Process.detach(child_pid)
        end
        end


      def emergency_mission_sim
        @location = Location.create(:name => "Emergency", :latitude => params[:latitude], :longitude => params[:longitude])
        @drone = Drone.find(1) # sim
        if @drone.status == "Busy"
          puts "Drone is Busy"
        else
        @mission = Mission.create(:name => "Emergency", :weight => 25, :status => "Ongoing", :user_id => 1, :mission_type => "Emergency", :location_id => @location.id, :drone_id => @drone.id)
        child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{params[:latitude]} #{params[:longitude]} 20 #{@mission.id} --drone_id #{@drone.id}")
        # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
        Process.detach(child_pid)
        @drone.update(:status => "Busy")
        end
        end

      def execute_emergency_mission
        @location = Location.create(:name => "Emergency", :latitude => params[:latitude], :longitude => params[:longitude])
        @drone = Drone.find(2) # real
        if @drone.status == "Busy"
          puts "Drone is Busy"
        else
        @mission = Mission.create(:name => "Emergency", :weight => 25, :status => "Ongoing", :user_id => 1, :mission_type => "Emergency", :location_id => @location.id, :drone_id => @drone.id)
        child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{params[:latitude]} #{params[:longitude]} 20 #{@mission.id} --drone_id #{@drone.id}")
        # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
        Process.detach(child_pid)

        @drone.update(:status => "Busy")
        end
      end

      def drone_params
        params.permit(:status)
      end
    end
  end
end