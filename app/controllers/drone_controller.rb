class DroneController < ApplicationController
  before_action :authenticate_user!, only: [:index ,:drone_registration, :drone_list, :drone_create, :users_list, :ban_user]
  before_action :check_ban

  def index

  end



  def nav_logs_json
    @drone = Drone.find(params[:drone])
    @nav_logs = NavLog.where(drone:@drone).order(:created_at)

    render :json => @nav_logs
  end

  def drone_mission
    @mission = Mission.new(drone_id: params[:drone_id])
  end

  def drone_tracker

    @drone = Drone.find(params[:drone])
    @nav_logs = NavLog.where(drone:@drone)
    @gps_latitude= @nav_logs.last.gps_latitude
    @gps_longitude= @nav_logs.last.gps_longitude

    logger.debug(@drone.name)
  end

  def users_list
    if current_user.admin
      @users = User.all
    else
      redirect_to drone_drone_list_path, alert: "You need admin privileges."
    end
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
      child_pid = spawn({"PATH" => "/home/ubuntu/.pyenv/shims:/home/ubuntu/.pyenv/bin:/home/ubuntu/.rbenv/plugins/ruby-build/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.local/bin"}, "python ~/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} --drone_id #{@drone.id}")
      # child_pid = spawn({"PATH" => "/home/adam/.pyenv/shims:/home/adam/.pyenv/bin:/home/adam/.rbenv/plugins/ruby-build/bin:/home/adam/.rbenv/shims:/home/adam/.rbenv/bin:/home/adam/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/adam/.local/bin"}, "python ~/drone/drone-comms/drone/mission.py #{connection_string} #{gps_latitude} #{gps_longitude} --drone_id #{@drone.id}")
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

  def drone_list
     @drones = Drone.order("created_at")
    # user = current_user
    # if user.admin

      # @drones = Drone.all
    # else
    #   @drones = Drone.where(:user => user)
    # end

  end

  def drone_edit
    @drone = Drone.find(params[:id])
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
