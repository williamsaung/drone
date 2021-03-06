class DroneController < ApplicationController
  before_action :authenticate_user!, only: [:index ,:drone_registration, :drone_list, :drone_create, :users_list, :ban_user, :drone_edit, :drone_update]
  before_action :check_ban


  def index

  end


  def update

  end


  def nav_logs_json
    @drone = Drone.find(params[:drone])
    @nav_logs = NavLog.where(drone:@drone).order(:created_at)


    render :json => @nav_logs.last

  end

  def drone_mission
    @mission = Mission.new(drone_id: params[:drone_id])
  end

  def release_servo
    @drone = Drone.find(params[:drone])
    child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/release_servo.py --port 9091")
    # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    Process.detach(child_pid)

    redirect_to drone_drone_tracker_path(:drone=>@drone.id)
  end

  def lock_servo
    @drone = Drone.find(params[:drone])
    child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/lock_servo.py --port 9091")
    # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    Process.detach(child_pid)

    redirect_to drone_drone_tracker_path(:drone=>@drone.id)
  end

  def terminate_mission
    if current_user.admin
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

    redirect_to missions_path

    else
      redirect_to missions_path, alert: "You need admin privileges."
    end
  end

  def drone_tracker
    @drone = Drone.find(params[:drone])
    @nav_logs = NavLog.where(drone:@drone)



      @gps_latitude= @nav_logs.last.gps_latitude
      @gps_longitude= @nav_logs.last.gps_longitude
      @altitude= @nav_logs.last.altitude
      @battery_voltage= @nav_logs.last.battery_voltage
      @battery_level= @nav_logs.last.battery_level
      @battery_current= @nav_logs.last.battery_current
      @ekf_ok= @nav_logs.last.ekf_ok
      @is_armable= @nav_logs.last.is_armable
      @system_status=@nav_logs.last.system_status
      @mode = @nav_logs.last.mode
      @armed = @nav_logs.last.armed
      @date = @nav_logs.last.created_at.in_time_zone('Asia/Bangkok')

    logger.debug(@drone.name)
  end

  def users_list
    if current_user.admin
      @users = User.all
    else
      redirect_to drone_drone_list_path, alert: "You need admin privileges."
    end
  end

  def users_mission
  @user = User.find(params[:id])
  @missions = Mission.where(:user => @user)
  end

  def ban_user
    @user = User.find(params[:id])
     @user.banned = true

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to drone_users_list_path, notice: 'User ban state has been updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_status
    @drone = Drone.find(params[:drone])

    if @drone.simulator?
      child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/status.py --drone_id #{@drone.id}")
      # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
      # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
      Process.detach(child_pid)
    else
      child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/status.py --drone_id #{@drone.id} --port 9091")
      # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
      Process.detach(child_pid)
    end

    sleep(2)
    redirect_to drone_drone_tracker_path(:drone=>@drone.id)
  end

  def status_change
    @drone = Drone.find(params[:id])

    @drone.status = params[:status]
    status = StatusLog.new
    status.drone = @drone
    status.status = @drone.status
    status.time = Time.now
    status.save


    respond_to do |format|
      if @drone.update(drone_params)
        format.html { redirect_to drone_drone_list_path, notice: 'Drone status has been updated.' }
        format.json { render :show, status: :ok, location: @drone }
      else
        format.html { render :edit }
        format.json { render json: @drone.errors, status: :unprocessable_entity }
      end
    end
  end

  def done
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



  def mission_status_change
    # @missions = Mission.order("drone_id")
    @mission_distance = Mission.find(params[:id])
    @forecast = Forecast.new()
    @forecast.save
    @weather = @forecast.get_weather_data
    @current_weather = @weather.currently.icon
    @distance = @mission_distance.location.distance
    # puts @distance

    @sim_battery = NavLog.where(:drone_id => 1).last.battery_level
    @real_battery = NavLog.where(:drone_id => 2).last.battery_level

    @real_battery_flight_time = @real_battery * 0.17647
    # @sim_battery_flight_time = @sim_battery * 0.17647
    @distance_flight_time = @distance/120


    if @current_weather == "rain" || @current_weather == "snow" || @current_weather == "sleet"
      redirect_to missions_path, alert: "BAD WEATHER!"
    elsif @real_battery_flight_time < @distance_flight_time
      redirect_to missions_path, alert: "Current drone battery level is not enough!"
    else

      @mission = Mission.find(params[:id])
      @uptime = Uptime.new('mission_id' => @mission.id, 'start_time' => Time.now)
      @uptime.save

      gps_latitude = @mission.location.latitude
      gps_longitude = @mission.location.longitude

      @mission.status = params[:mission_status]
      @mission.save!

      @drone = Drone.find(@mission.drone.id)
      @drone.status = params[:drone_status]
      @drone.save!



      connection_string = @drone.connection_string
      puts "Executing command 'python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude}'"

      # For simulators
      if @drone.simulator?
        child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{gps_latitude} #{gps_longitude} 20 #{@mission.id} --drone_id #{@drone.id}")
        # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
        # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
        Process.detach(child_pid)
      else
        child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{gps_latitude} #{gps_longitude} 20 #{@mission.id} --drone_id #{@drone.id} --port 9091 --base_port 8081")
        # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
        Process.detach(child_pid)
      end



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

    # @mission = Mission.find(params[:id])
    # gps_latitude = @mission.location.latitude
    # gps_longitude = @mission.location.longitude
    #
    # @drone = Drone.find(@mission.drone.id)
    # @drone.status = params[:drone_status]
    # @drone.save
    #
    # @mission.status = params[:mission_status]
    # @mission.save
    #
    # connection_string = @drone.connection_string
    # puts "Executing command 'python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude}'"
    #
    # # For simulators
    # if @drone.simulator?
    #   child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{gps_latitude} #{gps_longitude} 10 #{@mission.id} --drone_id #{@drone.id}")
    #   # child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    #   # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    #   Process.detach(child_pid)
    # else
    #   child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/thrift/delivery.py #{gps_latitude} #{gps_longitude} 10 #{@mission.id} --drone_id #{@drone.id} --port 9091")
    #   # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} #{@mission.id} --drone_id #{@drone.id}")
    #   Process.detach(child_pid)
    # end

    # respond_to do |format|
    #   if @mission.update(drone_params)
    #     format.html { redirect_to missions_path, notice: 'Drone status has been updated.' }
    #     format.json { render :show, status: :ok, location: @mission }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @mission.errors, status: :unprocessable_entity }
    #   end
    # end
  # end

  def weather_check
    @forecast = Forecast.new()
    @forecast.save
    @weather = @forecast.get_weather_data
    @current_weather = @weather.currently.icon
    puts @current_weather
    # render html: @current_weather

    if @current_weather == "clear-day"
        render html: "<script>alert('No users!')</script>".html_safe
    else
      redirect_to drone_mission_status_change_path
    end
  end

  def drone_list
     @drones = Drone.order("created_at")
  end

  def drone_edit

    @drone = Drone.find(params[:id])
  end


  def drone_update
    @drone = Drone.find(params[:id])
    respond_to do |format|
      if @drone.update(drone_params)
        format.html { redirect_to drone_drone_list_path, notice: 'Drone was successfully updated.' }
        format.json { render :show, status: :ok, location: @drone }
      else
        format.html { render :edit }
        format.json { render json: @drone.errors, status: :unprocessable_entity }
      end
    end
  end


  def drone_registration
    @drone = Drone.new
  end

  def drone_create
    @drone = Drone.new(drone_params)
    @drone.user = current_user
    @drone.status = "Available"
    @drone.simulator = false

    if @drone.save
      redirect_to drone_drone_list_path, alert: "Drone created successfully."
    else
      redirect_to drone_registration_path, alert: "Error registering drone."
    end
  end



  private


  def check_ban
    if current_user.banned
      flash[:error] = "Oh no! You've been banned. Please contact an admin for assistance."
      redirect_to root_path
    end
  end

  def drone_params
    params.permit(:name, :status, :description, :connection_string )
  end

  def user_params
    params.permit(:banned)
  end
end
