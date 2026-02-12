class PagesController < ApplicationController
  skip_authorization_check
  def home
    add_breadcrumb 'Home', root_path
  end

  def dashboard
    add_breadcrumb 'dashboard', dashboard_path
    @stations = Mmsi.where(category: :station).count
    @vessels = Mmsi.where(category: :vessel).count
    @unapproved_vessels = Mmsi.where(category: :vessel, status: false).count
    @unapproved_stations = Mmsi.where(category: :station, status: false).count
  end

  def unapproved_stations
    @stations = Station.includes(:mmsi).includes(:station_type).includes(:callsign).where(mmsis: { status: false, category: :station })
  end

  def unapproved_vessels
    @vessels = Vessel.includes(:mmsi).includes(:callsign).where(mmsis: { status: false, category: :vessel })
  end
end
