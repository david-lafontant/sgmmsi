class CallsignsController < ApplicationController
  before_action :set_callsign, only: %i[ show edit update destroy ]

  # GET /callsigns or /callsigns.json
  def index
    @callsigns = Callsign.all
  end

  # GET /callsigns/1 or /callsigns/1.json
  def show
  end

  # GET /callsigns/new
  def new
    @callsign = Callsign.new
  end

  # GET /callsigns/1/edit
  def edit
  end

  # POST /callsigns or /callsigns.json
  def create
    @callsign = Callsign.new(callsign_params)

    respond_to do |format|
      if @callsign.save
        format.html { redirect_to @callsign, notice: "Callsign was successfully created." }
        format.json { render :show, status: :created, location: @callsign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @callsign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /callsigns/1 or /callsigns/1.json
  def update
    respond_to do |format|
      if @callsign.update(callsign_params)
        format.html { redirect_to @callsign, notice: "Callsign was successfully updated.", status: :see_other }
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
      format.html { redirect_to callsigns_path, notice: "Callsign was successfully destroyed.", status: :see_other }
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
      params.expect(callsign: [ :call_sign_num, :mmsi_id, :user_id, :status, documents: [] ])
    end
end
