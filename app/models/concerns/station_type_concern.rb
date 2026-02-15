module StationTypeConcern
  include ActiveSupport::Concern

  def station_type_id_exists
    StationType.find(station_type_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(station_type_id, 'id key must exist')
    false
  end
end
