class Vessel < ApplicationRecord
  belongs_to :mmsi
  validates :registration_number,
            :operation_area, :name, presence: true
  has_many_attached :documents

  def generate_vessel_mmsi
    "003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end

  def display_mmsi(id)
    Mmsi.find(id).mmsi_id
  end

  def generate_callsign
    "call003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end
end
