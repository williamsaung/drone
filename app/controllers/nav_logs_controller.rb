class NavLogsController < ApplicationController
  before_action :set_nav_log, only: [:show, :edit, :update, :destroy]

  # GET /nav_logs
  # GET /nav_logs.json
  def index
    @nav_logs = NavLog.all
  end

  # GET /nav_logs/1
  # GET /nav_logs/1.json
  def show
  end

  # GET /nav_logs/new
  def new
    @nav_log = NavLog.new
  end

  # GET /nav_logs/1/edit
  def edit
  end

  # POST /nav_logs
  # POST /nav_logs.json
  #
  def test

  end

  def test_post

  end

  def create
    @nav_log = NavLog.new(nav_log_params)

    respond_to do |format|
      if @nav_log.save
        format.html { redirect_to @nav_log, notice: 'Nav log was successfully created.' }
        format.json { render :show, status: :created, location: @nav_log }
      else
        format.html { render :new }
        format.json { render json: @nav_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nav_logs/1
  # PATCH/PUT /nav_logs/1.json
  def update
    respond_to do |format|
      if @nav_log.update(nav_log_params)
        format.html { redirect_to @nav_log, notice: 'Nav log was successfully updated.' }
        format.json { render :show, status: :ok, location: @nav_log }
      else
        format.html { render :edit }
        format.json { render json: @nav_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nav_logs/1
  # DELETE /nav_logs/1.json
  def destroy
    @nav_log.destroy
    respond_to do |format|
      format.html { redirect_to nav_logs_url, notice: 'Nav log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nav_log
      @nav_log = NavLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nav_log_params
      params.require(:nav_log).permit(:altitude, :gps_latitude, :gps_longitude, :drone_id)
    end
end
