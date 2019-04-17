class MissionRecordsController < ApplicationController
  before_action :set_mission_record, only: [:show, :edit, :update, :destroy]

  # GET /mission_records
  # GET /mission_records.json
  def index
    @mission_records = MissionRecord.all
  end

  # GET /mission_records/1
  # GET /mission_records/1.json
  def show
  end

  # GET /mission_records/new
  def new
    @mission_record = MissionRecord.new
  end

  # GET /mission_records/1/edit
  def edit
  end

  # POST /mission_records
  # POST /mission_records.json
  def create
    @mission_record = MissionRecord.new(mission_record_params)

    respond_to do |format|
      if @mission_record.save
        format.html { redirect_to @mission_record, notice: 'Mission record was successfully created.' }
        format.json { render :show, status: :created, location: @mission_record }
      else
        format.html { render :new }
        format.json { render json: @mission_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mission_records/1
  # PATCH/PUT /mission_records/1.json
  def update
    respond_to do |format|
      if @mission_record.update(mission_record_params)
        format.html { redirect_to @mission_record, notice: 'Mission record was successfully updated.' }
        format.json { render :show, status: :ok, location: @mission_record }
      else
        format.html { render :edit }
        format.json { render json: @mission_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_records/1
  # DELETE /mission_records/1.json
  def destroy
    @mission_record.destroy
    respond_to do |format|
      format.html { redirect_to mission_records_url, notice: 'Mission record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission_record
      @mission_record = MissionRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mission_record_params
      params.require(:mission_record).permit(:latitude, :longitude, :drone_id)
    end
end
