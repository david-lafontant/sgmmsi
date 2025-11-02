class MmsisController < ApplicationController
  before_action :set_mmsi, only: %i[edit update destroy]

  def index
    @num_stations = Mmsi.where(category: 'station')
    @num_vessels = Mmsi.where(category: 'vessel')
  end

  def dashboard
    @stations = Mmsi.where(category: 'station').count
    @vessels = Mmsi.where(category: 'vessel').count
    @total_vessels = 1_000_000
    @total_station = 1_000_000
  end

  def edit; end

  def update
    respond_to do |format|
      if @mmsi.update(mmsi_params)
        format.html { redirect_to dashboard_path, notice: 'Mmsi was successfully updated.', status: :see_other }
        # format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mmsi.destroy!

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'mmsi was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_mmsi
    @mmsi = Mmsi.find(params.expect(:id))
  end

  def mmsi_params
    params.expect(mmsi: [:status])
  end
end
