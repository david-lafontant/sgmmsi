module MmsiConcern
  include ActiveSupport::Concern

  def display_mmsi(id)
    Mmsi.find(id).mmsi_id
  end

  def mmsi_id_exists
    Mmsi.find(mmsi_id)
  rescue ActiveRecord::RecordNotFound
    errors.add(:mmsi_id, 'user_id key must exist')
    false
  end
end
