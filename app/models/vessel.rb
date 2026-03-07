class Vessel < ApplicationRecord
  attribute :user

  include EmailConcern
  include CallsignConcern
  include MmsiConcern
  include UserConcern

  belongs_to :mmsi
  belongs_to :user
  has_one :callsign, through: :mmsi
  has_many_attached :documents

  string_regex = Regexp.new(/\A[[:alpha:]][[:alnum:]\- ]*\z/u, Regexp::IGNORECASE)
  registration_number_regex = Regexp.new(/\A[a-zA-Z]{2}\d{5}\z/, Regexp::IGNORECASE)
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg', 'application/pdf'].freeze
  validates :registration_number,
            :operation_area, :name, presence: true
  validate :user_id_exists
  validate :mmsi_id_exists
  validates :name, :operation_area, length: { in: 3..40 }, format: { with: string_regex, message: 'Invalid format' }
  validates :registration_number, format: { with: registration_number_regex, message: 'Invalid format' }
  validates :documents, total_size: { less_than_or_equal_to: 20.megabytes }, content_type: ACCEPTED_CONTENT_TYPES

  before_save :upcase_inputs
  def generate_vessel_mmsi
    "003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end

  def self.import(file) # rubocop:disable Metrics/AbcSize
    spreadsheet = Roo::Excelx.new(file.tempfile.path)
    headers = spreadsheet.row(1) # Assuming the first row contains headers
    headers.map!(&:strip)
    spreadsheet.each_with_index do |row, idx|
      next if idx.zero? # Skip header row

      vessel_data = [headers, row].transpose.to_h
      vessel = find_by(registration_number: vessel_data['registration_number']) || new
      vessel.attributes = vessel_data
      vessel.user_id = Current.user.id
      mmsi = vessel.generate_vessel_mmsi
      ref1 = Mmsi.create(mmsi_number: mmsi, user_id: Current.user.id, category: 'vessel')
      call1 = Callsign.create(mmsi_id: ref1.id, user_id: Current.user.id, call_sign_num: vessel.generate_callsign)
      vessel.mmsi_id = ref1.id
      next if vessel.save

      ref1.destroy
      call1.destroy
    end
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
