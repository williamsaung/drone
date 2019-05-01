class UptimesController < ApplicationController
  before_action :set_uptime, only: [:show, :edit, :update, :destroy]

  # GET /uptimes
  # GET /uptimes.json
  def index
    @uptimes = Uptime.all
  end

  # GET /uptimes/1
  # GET /uptimes/1.json
  def show
  end

  # GET /uptimes/new
  def new
    @uptime = Uptime.new
  end

  # GET /uptimes/1/edit
  def edit
  end

  # POST /uptimes
  # POST /uptimes.json
  def create
    @uptime = Uptime.new(uptime_params)

    respond_to do |format|
      if @uptime.save
        format.html { redirect_to @uptime, notice: 'Uptime was successfully created.' }
        format.json { render :show, status: :created, location: @uptime }
      else
        format.html { render :new }
        format.json { render json: @uptime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uptimes/1
  # PATCH/PUT /uptimes/1.json
  def update
    respond_to do |format|
      if @uptime.update(uptime_params)
        format.html { redirect_to @uptime, notice: 'Uptime was successfully updated.' }
        format.json { render :show, status: :ok, location: @uptime }
      else
        format.html { render :edit }
        format.json { render json: @uptime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uptimes/1
  # DELETE /uptimes/1.json
  def destroy
    @uptime.destroy
    respond_to do |format|
      format.html { redirect_to uptimes_url, notice: 'Uptime was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uptime
      @uptime = Uptime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uptime_params
      params.require(:uptime).permit(:start_time, :end_time, :mission_id)
    end
end
