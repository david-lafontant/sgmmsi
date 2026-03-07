class StationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_station, only: %i[show edit update destroy]

  # GET /stations or /stations.json
  def index
    @q = Station.ransack(search_params)
    @stations = @q.result(distinct: true).includes(:mmsi, :callsign, :user, :station_type).order(created_at: :desc).all
    respond_to do |format|
      format.html { @stations = @stations.page(params[:page]) }
      # format.csv { send_data @stations }
    end
  end

  # GET /stations/search
  # Alternative endpoint for AJAX searches
  def search
    @q = Station.ransack(search_params)
    @stations = @q.result(distinct: true)
      .includes(:mmsi, :callsign, :user, :station_type)
      .limit(50)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @stations }
      format.turbo_stream
    end
  end

  def import
    Station.import(params[:file])
    respond_to do |format|
      format.html { render :index, notice: 'Data imported successfully!' }
      format.json { render json: @stations }
      format.turbo_stream
    end
    # redirect_to vessels_url, notice: 'Data imported successfully!'
  end

  # GET /stations/1 or /stations/1.json
  def show; end

  # GET /stations/new
  def new
    @station = Station.new
  end

  # GET /stations/1/edit
  def edit; end

  # POST /stations or /stations.json
  def create # rubocop:disable Metrics/AbcSize
    @station = Station.new(station_params)
    @station.user_id = current_user.id
    station_category = StationType.find(@station.station_type_id).category
    mmsi = @station.generate_station_mmsi(station_category)
    ref1 = Mmsi.create(mmsi_number: mmsi, user_id: current_user.id, category: 'station')
    call1 = Callsign.create(mmsi_id: ref1.id, user_id: current_user.id, call_sign_num: @station.generate_callsign)
    @station.mmsi_id = ref1.id

    respond_to do |format|
      if @station.save
        format.html { redirect_to @station, notice: 'Station was successfully created.' }
        format.json { render :show, status: :created, location: @station }
      else
        ref1.destroy
        call1.destroy
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations/1 or /stations/1.json
  def update
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: 'Station was successfully updated.', status: :see_other }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1 or /stations/1.json
  def destroy
    station_mmsi = @station.mmsi_id
    @station.destroy!
    Mmsi.find(station_mmsi).destroy!

    respond_to do |format|
      format.html { redirect_to stations_path, notice: 'Station was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_station
    @station = Station.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def station_params
    params.expect(station: [:registration_number, :latitude, :longitude, :municipality, :station_type_id, :last_name, :first_name, :email,
                            :telephone, { documents: [] }])
  end

  def search_params
    params.fetch(:q, {}).permit(
      :registration_number_eq,
      :municipality_cont,
      :station_type_id_eq,
      :email_cont,
      :user_id_eq,
      :created_at_gteq,
      :created_at_lteq,
      :mmsi_mmsi_number_cont,
      :mmsi_status_eq,
      :station_type_id,
      :callsign_call_sign_num_cont,
      :s, # Sort parameter
      municipality_in: [],
      station_type_category_in: [],
      created_at_in: []
    )
  end
end
