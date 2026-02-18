class VesselsController < ApplicationController
  load_and_authorize_resource
  before_action :set_vessel, only: %i[show edit update destroy]

  # GET /vessels or /vessels.json
  def index
    @q = Vessel.ransack(search_params)
    @vessels = @q.result(distinct: true).includes(:mmsi, :callsign, :user).order(created_at: :desc).all
    respond_to do |format|
      format.html { @vessels = @vessels.page(params[:page]) }
      # format.csv { send_data @vessels }
    end
  end

  # GET /stations/search
  # Alternative endpoint for AJAX searches
  def search
    @q = Vessel.ransack(search_params)
    @vessels = @q.result(distinct: true)
      .includes(:mmsi, :callsign, :user)
      .limit(50)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @vessels }
      format.turbo_stream
    end
  end

  # GET /vessels/1 or /vessels/1.json
  def show; end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
  end

  # GET /vessels/1/edit
  def edit; end

  # POST /vessels or /vessels.json
  def create
    @vessel = Vessel.new(vessel_params)
    @vessel.user_id = current_user.id
    mmsi = @vessel.generate_vessel_mmsi
    ref1 = Mmsi.create(mmsi_number: mmsi, user_id: current_user.id, category: 'vessel')
    call1 = Callsign.create(mmsi_id: ref1.id, user_id: current_user.id, call_sign_num: @vessel.generate_callsign)
    @vessel.mmsi_id = ref1.id
    respond_to do |format|
      if @vessel.save
        format.html { redirect_to @vessel, notice: 'Vessel was successfully created.' }
        format.json { render :show, status: :created, location: @vessel }
      else
        ref1.destroy
        call1.destroy
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vessels/1 or /vessels/1.json
  def update
    respond_to do |format|
      if @vessel.update(vessel_params)
        format.html { redirect_to @vessel, notice: 'Vessel was successfully updated.', status: :see_other }
        format.json { render :show, status: :ok, location: @vessel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vessels/1 or /vessels/1.json
  def destroy
    vessel_mmsi = @vessel.mmsi_id
    @vessel.destroy!
    Mmsi.find(vessel_mmsi).destroy!

    respond_to do |format|
      format.html { redirect_to vessels_path, notice: 'Vessel was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vessel
    @vessel = Vessel.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def vessel_params
    params.expect(vessel: [:registration_number, :operation_area, :name, {
                    documents: []
                  }])
  end

  def search_params
    params.fetch(:q, {}).permit(
      :name_cont,
      :operation_area_cont,
      :registration_number_eq,
      :user_id_eq,
      :created_at_gteq,
      :created_at_lteq,
      :mmsi_mmsi_number_cont,
      :mmsi_status_eq,
      :callsign_call_sign_num_cont,
      :s, # Sort parameter
      operation_area_in: [],
      created_at_in: []
    )
  end
end
