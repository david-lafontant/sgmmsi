class Vessel < ApplicationRecord
  include EmailConcern
  include CallsignConcern
  include MmsiConcern
  include UserConcern

  belongs_to :mmsi
  belongs_to :user
  has_one :callsign, through: :mmsi
  has_many_attached :documents

  string_regex = Regexp.new(/\A(?=.{3,40}\z)[A-Za-z-]+(?: [A-Za-z-]+)*\z/, Regexp::IGNORECASE)
  registration_number_regex = Regexp.new(/\A[a-zA-Z]{2}\d{5}\z/, Regexp::IGNORECASE)
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg', 'application/pdf'].freeze
  validates :registration_number,
            :operation_area, :name, presence: true
  validate :user_id_exists
  validate :mmsi_id_exists
  validates :name, :operation_area, format: { with: string_regex, message: 'Invalid format' }
  validates :registration_number, format: { with: registration_number_regex, message: 'Invalid format' }
  validates :documents, total_size: { less_than_or_equal_to: 20.megabytes }, content_type: ACCEPTED_CONTENT_TYPES

  before_save :upcase_inputs
  def generate_vessel_mmsi
    "003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[registration_number
       operation_area
       mmsi_id
       user_id
       created_at
       updated_at
       name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[mmsi callsign user]
  end

  private

  def upcase_inputs
    self.name = name.strip.upcase
    self.registration_number = registration_number.strip.upcase
    self.operation_area = operation_area.strip.upcase
  end
end
