class PagesController < ApplicationController
  skip_authorization_check
  def home
    add_breadcrumb 'Home', root_path
  end

  def dashboard
    add_breadcrumb 'dashboard', dashboard_path
    @stations = Station.includes(:mmsi).count
    @vessels = Vessel.includes(:mmsi).count
    @unapproved_vessels = Vessel.includes(:mmsi).where(mmsis: { status: false }).count
    @unapproved_stations = Station.includes(:mmsi).where(mmsis: { status: false }).count
  end

  def unapproved_stations
    @stations = Station.includes(:mmsi, :station_type, :callsign,
                                 :user).where(mmsis: { status: false }).order(created_at: :desc).all

    respond_to do |format|
      format.html { @stations = @stations.page(params[:page]) }
      format.csv { @stations }
      format.xlsx { @stations }
    end
  end

  def unapproved_vessels
    @vessels = Vessel.includes(:mmsi, :callsign, :user).where(mmsis: { status: false }).order(created_at: :desc).all
    respond_to do |format|
      format.html { @vessels = @vessels.page(params[:page]) }
      format.csv { @vessels }
      format.xlsx { @vessels }
    end
  end
end
