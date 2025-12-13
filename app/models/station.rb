class Station < ApplicationRecord
  belongs_to :station_type
  belongs_to :mmsi
  belongs_to :user, optional: true
  has_many_attached :documents

  validates :registration_number,
            :latitude,
            :longitude,
            :municipality,
            :last_name,
            :first_name,
            :email,
            :telephone, presence: true
  def generate_station_mmsi(id)
    mmsi = nil
    case id
    when 1
      mmsi = "003291#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 2
      mmsi = "003292#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 3
      mmsi = "003293#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 4
      mmsi = "003294#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 5
      mmsi = "003295#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    else
      raise StandardError, 'Error.'
    end
    mmsi
  end

  def display_mmsi(id)
    Mmsi.find(id).mmsi_id
  end

  def display_station_type(id)
    StationType.find(id).category
  end

  def generate_callsign
    "call003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end
end
