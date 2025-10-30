class Mmsi < ApplicationRecord
  belongs_to :user
  has_one :vessel
  has_one :station
  validates :mmsi_id, presence: true, uniqueness: true

  validates :category, inclusion: { in: %w[station vessel], message: 'invalid data' }
end
