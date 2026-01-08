module StationTypeConcern
  include ActiveSupport::Concern

  def station_type_id_exists
    StationType.find(station_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(:station_id, 'station_id key must exist')
    false
  end
end
