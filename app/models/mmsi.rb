class Mmsi < ApplicationRecord
  belongs_to :user
  has_one :vessel
  validates :mmsi_id, presence: true
end
