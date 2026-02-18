class PagesController < ApplicationController
  skip_authorization_check
  def home
    add_breadcrumb 'Home', root_path
  end

  def dashboard
    add_breadcrumb 'dashboard', dashboard_path
    @stations = Station.includes(:mmsi).where(mmsi: { category: :station }).count
    @vessels = Vessel.includes(:mmsi).where(mmsi: { category: :vessel }).count
    @unapproved_vessels = Vessel.includes(:mmsi).where(mmsis: { status: false, category: :vessel }).count
    @unapproved_stations = Station.includes(:mmsi).where(mmsis: { status: false, category: :station }).count
  end

  def unapproved_stations
    @stations = Station.includes(:mmsi, :station_type, :callsign,
                                 :user).where(mmsis: { status: false, category: :station }).order(created_at: :desc).all

    respond_to do |format|
      format.html { @stations = @stations.page(params[:page]) }
      format.csv { @stations }
      format.xlsx { @stations }
    end
  end

  def unapproved_vessels
    @vessels = Vessel.includes(:mmsi, :callsign, :user).where(mmsis: { status: false, category: :vessel }).order(created_at: :desc).all
    respond_to do |format|
      format.html { @vessels = @vessels.page(params[:page]) }
      format.csv { @vessels }
    end
  end
end
