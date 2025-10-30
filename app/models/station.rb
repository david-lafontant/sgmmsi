class Station < ApplicationRecord
  belongs_to :station_type
  belongs_to :mmsi
  belongs_to :user
  has_many_attached :documents
end
