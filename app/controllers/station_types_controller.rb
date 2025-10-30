class StationTypesController < ApplicationController
  before_action :set_station_type, only: %i[show edit update destroy]

  # GET /station_types or /station_types.json
  def index
    @station_types = StationType.all
  end

  # GET /station_types/1 or /station_types/1.json
  def show; end

  # GET /station_types/new
  def new
    @station_type = StationType.new
  end

  # GET /station_types/1/edit
  def edit; end

  # POST /station_types or /station_types.json
  def create
    @station_type = StationType.new(station_type_params)

    respond_to do |format|
      if @station_type.save
        format.html { redirect_to @station_type, notice: 'Station type was successfully created.' }
        format.json { render :show, status: :created, location: @station_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @station_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /station_types/1 or /station_types/1.json
  def update
    respond_to do |format|
      if @station_type.update(station_type_params)
        format.html { redirect_to @station_type, notice: 'Station type was successfully updated.', status: :see_other }
        format.json { render :show, status: :ok, location: @station_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @station_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /station_types/1 or /station_types/1.json
  def destroy
    @station_type.destroy!

    respond_to do |format|
      format.html { redirect_to station_types_path, notice: 'Station type was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_station_type
    @station_type = StationType.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def station_type_params
    params.expect(station_type: [:category])
  end
end
