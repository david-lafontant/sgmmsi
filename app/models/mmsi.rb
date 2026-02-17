class Mmsi < ApplicationRecord
  include UserConcern

  has_one :vessel, dependent: :destroy
  has_one :station, dependent: :destroy
  has_one :callsign, dependent: :destroy
  belongs_to :user
  validates :mmsi_number, presence: true, uniqueness: true,
                          format: {
                            with: /\A00329[0-5]\d{5}\z/,
                            message: 'nvalid format'
                          }

  validates :category, inclusion: { in: %w[station vessel], message: 'invalid data' }
  after_initialize :set_default_status, if: :new_record?

  def self.ransackable_attributes(_auth_object = nil)
    %w[mmsi_number
       user_id
       created_at
       category
       status]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[station vessel callsign user]
  end

  private

  def set_default_status
    self[:status] ||= false
  end
end
