class DroneController < ApplicationController
  before_action :authenticate_user!, only: [:drone_registration, :drone_list, :drone_create, :users_list, :ban_user]
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

    online_status_logs = StatusLog.where(status: "Online")
    online_status_logs = online_status_logs.order(:created_at)

    @up_time = Time.now - online_status_logs.last.created_at


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

  # def new
  #   @drone = Drone.find(params[:id])
  #   # @mission = Mission.new(drone: params[:drone_id])
  # end

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
    @drone = Drone.find(@mission.drone.id)
    @drone.status = params[:drone_status]
    @drone.save


    @mission.status = params[ :mission_status]
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

  def drone_list
    user = current_user
    if user.admin
      @drones = Drone.all
    else
      @drones = Drone.where(:user => user)
    end

  end

  def drone_registration
    @drone = Drone.new
  end

  def drone_create
    @drone = Drone.new(drone_params)
    @drone.user = current_user
    @drone.status = "Available"

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
    params.permit(:name, :status, )
  end

  def user_params
    params.permit(:banned)
  end
end
