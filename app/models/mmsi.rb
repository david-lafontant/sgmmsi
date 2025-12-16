class Mmsi < ApplicationRecord
  has_one :vessel, dependent: :destroy
  has_one :station, dependent: :destroy
  has_many :callsigns, dependent: :destroy
  validates :mmsi_id, presence: true, uniqueness: true

  validates :category, inclusion: { in: %w[station vessel], message: 'invalid data' }
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self[:status] ||= false
  end
end
