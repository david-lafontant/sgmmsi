class Station < ApplicationRecord
  include EmailConcern
  include CallsignConcern
  include MmsiConcern
  include UserConcern
  include StationTypeConcern

  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg', 'application/pdf'].freeze
  registration_number_regex = Regexp.new(/\A[a-zA-Z]{2}\d{5}\z/, Regexp::IGNORECASE)
  phone_regex = Regexp.new(/\A\d{8}\z/, Regexp::IGNORECASE)
  string_regex = Regexp.new(/\A[A-Za-z\s]{3,50}\z/, Regexp::IGNORECASE)

  belongs_to :station_type
  belongs_to :mmsi
  has_one :callsign, through: :mmsi
  has_many_attached :documents

  validates :documents, total_size: { less_than_or_equal_to: 20.megabytes }, content_type: ACCEPTED_CONTENT_TYPES # restricts the total size to <= 10MB
  validates :registration_number,
            :latitude,
            :longitude,
            :municipality,
            :last_name,
            :first_name,
            :email,
            :telephone, presence: true
  validate :user_id_exists
  validate :mmsi_id_exists
  validate :station_type_id_exists
  validates :latitude, numericality: { in: 18..20 }
  validates :longitude, numericality: { in: 71..74 }
  validates :municipality,
            :last_name,
            :first_name, length: { in: 3..40 }, format: { with: string_regex,
                                                          message: 'invalid format' }
  validates :telephone, format: { with: phone_regex, message: 'invalid format' }
  validates :registration_number, format: { with: registration_number_regex,
                                            message: 'invalid format' }
  def display_station_type(id)
    StationType.find(id).category
  end

  def generate_station_mmsi(category)
    mmsi = nil
    case category
    when 'COTIERE'
      mmsi = "003291#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 'PORTUAIRES'
      mmsi = "003292#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 'PILOTAGE'
      mmsi = "003293#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 'REPETEUR AIS'
      mmsi = "003294#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    when 'BASE AIS'
      mmsi = "003295#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
    else
      raise StandardError, 'Error.'
    end
    mmsi
  end
  before_save :upcase_inputs

  private

  def upcase_inputs
    self.registration_number = registration_number.strip.upcase
    self.last_name = last_name.strip.upcase
    self.first_name = first_name.strip.upcase
    self.municipality = municipality.strip.upcase
  end
end
