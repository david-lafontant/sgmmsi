class CallsignsController < ApplicationController
  before_action :set_callsign, only: %i[show destroy]

  # GET /callsigns or /callsigns.json
  def index
    @callsigns = Callsign.all
  end

  # GET /callsigns/1 or /callsigns/1.json
  def show; end

  # GET /callsigns/new
  def new
    @callsign = Callsign.new
  end

  # GET /callsigns/1/edit
  def edit
    @callsign = Callsign.find(params.expect(:id))
  end

  # POST /callsigns or /callsigns.json
  def create
    @callsign = Callsign.new(callsign_params)
    @callsign.user_id = current_user.id
    @callsign.call_sign_num = @callsign.generate_callsign
    respond_to do |format|
      if @callsign.save
        format.html { redirect_to @callsign, notice: 'Callsign was successfully created.' }
        format.json { render :show, status: :created, location: @callsign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @callsign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callsigns/1 or /callsigns/1.json
  def update
    @callsign = Callsign.find(params.expect(:id))

    respond_to do |format|
      if @callsign.update(params.expect(callsign: [:status]))
        format.html { redirect_to @callsign, notice: 'Callsign was successfully updated.', status: :see_other }
        format.json { render :show, status: :ok, location: @callsign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @callsign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /callsigns/1 or /callsigns/1.json
  def destroy
    @callsign.destroy!

    respond_to do |format|
      format.html { redirect_to callsigns_path, notice: 'Callsign was successfully destroyed.', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_callsign
    @callsign = Callsign.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def callsign_params
    params.expect(callsign: [:mmsi_id, { documents: [] }])
  end
end
