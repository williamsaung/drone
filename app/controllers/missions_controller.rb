class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index]
  # GET /missions
  # GET /missions.json
  def index
    @missions = Mission.order("drone_id")
    user = current_user
    if user.admin
      @missions = Mission.all
    else
      @missions = Mission.where(:user => user)
    end

  end

  # GET /missions/1
  # GET /missions/1.json
  def show
  end

  # GET /missions/new
  def new
    @mission = Mission.new
  end

  # GET /missions/1/edit
  def edit
  end

  def endtime

  end

  def search
    if params[:search].blank?
      @missions = Mission.all
    else
      @missions = Mission.search(params)
    end
  end

  # POST /missions
  # POST /missions.json
  def create
    @mission = Mission.new(mission_params.merge(user_id: current_user.id))
    @mission.status = "Saved"
    @mission.mission_type = "Delivery"

    respond_to do |format|
      if @mission.save
        format.html { redirect_to missions_path, notice: 'Mission was successfully created.' }
        format.json { render :show, status: :created, location: @mission }
      else
        format.html { render :new }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  def status_change
    @drone = Drone.find(params[:id])
    @drone.status = params[:status]

    mis_status = StatusLog.new
    mis_status.mission = @drone
    mis_status.status = @drone.status
    mis_status.save

    respond_to do |format|
      if @drone.update(drone_params)
        format.html { redirect_to missions_path, notice: 'Mission status has been updated.' }
        format.json { render :show, status: :ok, location: @drone}
      else
        format.html { render :edit }
        format.json { render json: @drone.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /missions/1
  # PATCH/PUT /missions/1.json
  def update
    respond_to do |format|
      if @mission.update(mission_params)
        format.html { redirect_to @mission, notice: 'Mission was successfully updated.' }
        format.json { render :show, status: :ok, location: @mission }
      else
        format.html { render :edit }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    render :conflict
  end

  # DELETE /missions/1
  # DELETE /missions/1.json
  def destroy
    if current_user.admin
      @users = User.all

    @mission.destroy
    respond_to do |format|
      format.html { redirect_to missions_path, notice: 'Mission was successfully destroyed.' }
      format.json { head :no_content }
    end

    else
      redirect_to missions_path, alert: "You need admin privileges."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mission_params
      params.require(:mission).permit(:name, :location_id, :weight, :drone_id, :status, :mission_id, :user_id, :lock_version)
    end
end

def drone_params
  params.permit(:name, :status)
end