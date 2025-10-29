class VesselsController < ApplicationController
  before_action :set_vessel, only: %i[show edit update destroy]

  # GET /vessels or /vessels.json
  def index
    @vessels = Vessel.all
  end

  # GET /vessels/1 or /vessels/1.json
  def show
  end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
  end

  # GET /vessels/1/edit
  def edit
  end

  # POST /vessels or /vessels.json
  def create
    @vessel = Vessel.new(vessel_params)
    @vessel.user_id = current_user.id
    mmsi = @vessel.generate_mmsi
    ref1 = Mmsi.create(mmsi_id: mmsi, user_id: current_user.id)
    @vessel.mmsi_id = ref1.id
    respond_to do |format|
      if @vessel.save
        format.html { redirect_to @vessel, notice: 'Vessel was successfully created.' }
        format.json { render :show, status: :created, location: @vessel }
      else
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
    @vessel.destroy!

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
    params.expect(vessel: [:registration_number, :operation_area, :last_name, :first_name, :company_name, :email, :telephone, {
                    documents: []
                  }])
  end
end
