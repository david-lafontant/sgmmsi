class Vessel < ApplicationRecord
  belongs_to :mmsi
  belongs_to :user
  validates :registration_number,
            :operation_area,
            :last_name,
            :first_name,
            :company_name,
            :email,
            :telephone, presence: true
  has_many_attached :documents

  def generate_vessel_mmsi
    "003290#{SecureRandom.random_number(10**5).to_s.rjust(5, '0')}"
  end
end
