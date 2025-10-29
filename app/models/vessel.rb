class Vessel < ApplicationRecord
  belongs_to :mmsi
  belongs_to :user
  has_many_attached :documents
end
