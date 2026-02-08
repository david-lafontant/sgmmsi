class PagesController < ApplicationController
  skip_authorization_check
  def home; end

  def dashboard
    @stations = Mmsi.where(category: 'station').count
    @vessels = Mmsi.where(category: 'vessel').count
    @unapproved_vessels = Mmsi.where(category: 'vessel').where(status: false).count
    @unapproved_stations = Mmsi.where(category: 'station').where(status: false).count
  end
end
