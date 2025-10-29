class Mmsi < ApplicationRecord
  belongs_to :user

  validates :mmsi_id, presence: true
end
